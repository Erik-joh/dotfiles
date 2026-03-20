return {
  "ThePrimeagen/99",
  dependencies = {
    "saghen/blink.cmp",
    { "saghen/blink.compat", version = "2.*" },
  },
  config = function()
    local _99 = require("99")

    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    _99.setup({
      -- OpenCodeProvider is the default, no need to set explicitly
      model = "github-copilot/claude-opus-4.6",
      logger = {
        level = _99.DEBUG,
        path = "/tmp/" .. basename .. ".99.debug",
        print_on_error = true,
      },

      md_files = {
        "AGENT.md",
      },

      completion = {
        source = "blink",
      },
    })

    local state = _99.__get_state()

    -- Monkey-patch: OpenCode requires reading a file before overwriting it.
    -- The default 99 prompt says "never read TEMP_FILE", which conflicts.
    -- Override read_tmp to instruct the AI to read first, then write.
    state.prompts.prompts.read_tmp = function()
      return [[
Before writing to TEMP_FILE, read it first.
Previous contents, which may not exist, can be written over without worry.
After writing TEMP_FILE once you should be done. Be done and end the session.
]]
    end

    -- Monkey-patch: Disable MCP servers for 99 invocations.
    -- OpenCode starts MCP servers (chrome-devtools, obsidian) as child processes.
    -- These don't terminate when the task completes, causing `opencode run` to hang
    -- indefinitely. Use a separate config with MCP servers disabled.
    local providers = require("99.providers")
    local config_99 = vim.fn.expand("~/.config/opencode/config-99.json")

    function providers.OpenCodeProvider._build_command(_, query, context)
      return {
        "env",
        "OPENCODE_CONFIG=" .. config_99,
        "opencode",
        "run",
        "-m",
        context.model,
        query,
      }
    end

    -- Monkey-patch: Timer + file poll workaround for OpenCode hanging.
    -- `opencode run` via vim.system (no TTY) completes its work and writes
    -- to the temp file, but the process never exits. We poll the temp file
    -- and kill the process after a grace period once the file is written.
    local function once(fn)
      local called = false
      return function(...)
        if called then
          return
        end
        called = true
        fn(...)
      end
    end

    function providers.OpenCodeProvider:make_request(query, context, observer)
      observer.on_start()

      local logger = context.logger:set_area(self:_get_provider_name())
      local once_complete = once(observer.on_complete)

      local command = self:_build_command(query, context)
      logger:debug("make_request", "command", command)

      -- Record initial temp file state for change detection
      local file_written = false
      local initial_stat = vim.uv.fs_stat(context.tmp_file)
      local initial_mtime = initial_stat and initial_stat.mtime and initial_stat.mtime.sec or 0
      local initial_size = initial_stat and initial_stat.size or 0

      local timer = nil
      local proc = nil

      -- Safely stop and close the timer
      local function stop_timer()
        if timer then
          pcall(function()
            timer:stop()
            timer:close()
          end)
          timer = nil
        end
      end

      -- Poll: check if temp file was modified and is non-empty
      local function poll_temp_file()
        if file_written or context:is_cancelled() or context:is_completed() then
          stop_timer()
          return
        end

        local stat = vim.uv.fs_stat(context.tmp_file)
        if
          stat
          and stat.size > 0
          and (stat.mtime.sec > initial_mtime or stat.size ~= initial_size)
        then
          file_written = true
          logger:debug("poll: temp file written, size=" .. stat.size .. ", waiting grace period")

          -- Grace period: 3 seconds, then kill
          stop_timer()
          timer = vim.uv.new_timer()
          timer:start(
            3000,
            0,
            vim.schedule_wrap(function()
              stop_timer()
              if proc and not context:is_cancelled() and not context:is_completed() then
                logger:debug("poll: grace period over, killing process")
                pcall(function()
                  proc:kill(15)
                end) -- SIGTERM
              end
            end)
          )
        end
      end

      proc = vim.system(command, {
        text = true,
        stdout = vim.schedule_wrap(function(err, data)
          logger:debug("stdout", "data", data)
          if context:is_cancelled() then
            once_complete("cancelled", "")
            return
          end
          if err and err ~= "" then
            logger:debug("stdout#error", "err", err)
          end
          if not err and data then
            observer.on_stdout(data)
          end
        end),
        stderr = vim.schedule_wrap(function(err, data)
          logger:debug("stderr", "data", data)
          if context:is_cancelled() then
            once_complete("cancelled", "")
            return
          end
          if err and err ~= "" then
            logger:debug("stderr#error", "err", err)
          end
          if not err then
            observer.on_stderr(data)
          end
        end),
      }, vim.schedule_wrap(function(obj)
        stop_timer()

        if context:is_cancelled() then
          once_complete("cancelled", "")
          return
        end

        -- If we killed the process after detecting the file was written,
        -- treat the non-zero exit code as success
        if obj.code ~= 0 and file_written then
          logger:debug("on_exit: process killed after file written, treating as success")
          vim.schedule(function()
            local ok, res = self:_retrieve_response(context)
            if ok then
              once_complete("success", res)
            else
              once_complete("failed", "unable to retrieve response from temp file")
            end
          end)
        elseif obj.code ~= 0 then
          local str = string.format("process exit code: %d\n%s", obj.code, vim.inspect(obj))
          once_complete("failed", str)
          logger:fatal(self:_get_provider_name() .. " make_query failed", "obj from results", obj)
        else
          vim.schedule(function()
            local ok, res = self:_retrieve_response(context)
            if ok then
              once_complete("success", res)
            else
              once_complete("failed", "unable to retrieve response from temp file")
            end
          end)
        end
      end))

      -- Start polling: 5s initial delay (give opencode time to start), then every 2s
      timer = vim.uv.new_timer()
      timer:start(5000, 2000, poll_temp_file)

      context:_set_process(proc)
    end

    -- Search: agentic search across the project, results go to quickfix
    vim.keymap.set("n", "<leader>9s", function()
      _99.search()
    end, { desc = "99: Search" })

    -- Visual: replace selection with AI-generated result
    vim.keymap.set("v", "<leader>9v", function()
      _99.visual()
    end, { desc = "99: Visual replace" })

    -- Stop: cancel all in-flight requests
    vim.keymap.set("n", "<leader>9x", function()
      _99.stop_all_requests()
    end, { desc = "99: Stop all requests" })

    -- Open: view previous interaction results
    vim.keymap.set("n", "<leader>9o", function()
      _99.open()
    end, { desc = "99: Open results" })

    -- Logs: view debug logs
    vim.keymap.set("n", "<leader>9l", function()
      _99.view_logs()
    end, { desc = "99: View logs" })

    -- Clear: clear previous search/visual results
    vim.keymap.set("n", "<leader>9c", function()
      _99.clear_previous_requests()
    end, { desc = "99: Clear previous" })
  end,
}
