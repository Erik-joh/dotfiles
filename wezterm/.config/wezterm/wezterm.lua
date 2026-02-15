local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Performance
config.front_end = 'WebGpu'
config.max_fps = 120
config.animation_fps = 0
config.cursor_blink_rate = 0

-- Font
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 18
config.line_height = 1.4
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Cursor
config.default_cursor_style = 'SteadyBlock'
config.colors = {
  cursor_bg = '#bbbbbb',
}

-- Window
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12,
}
config.window_decorations = 'RESIZE'
config.window_background_opacity = 0.92
config.macos_window_background_blur = 20
config.adjust_window_size_when_changing_font_size = false

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32


config.color_scheme = 'Tokyo Night'

config.keys = {
  -- Tabs
  { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'CMD', action = act.ActivateTabRelative(1) },
  { key = 'p', mods = 'CMD', action = act.ActivateTabRelative(-1) },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentTab { confirm = true } },

  -- Direct tab switching
  { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = act.ActivateTab(4) },

  -- Splits (if you ever need them)
  { key = 's', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- Navigate splits vim-style
  { key = 'h', mods = 'CMD', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'CMD', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'CMD', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'CMD', action = act.ActivatePaneDirection 'Right' },

  -- Resize splits
  { key = 'H', mods = 'CMD', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'J', mods = 'CMD', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'K', mods = 'CMD', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'L', mods = 'CMD', action = act.AdjustPaneSize { 'Right', 5 } },

  -- Copy mode (vim-style visual selection)
  { key = 'e', mods = 'CMD', action = act.ActivateCopyMode },

  -- Quick actions
  { key = 'z', mods = 'CMD', action = act.TogglePaneZoomState },
  { key = 'f', mods = 'CMD', action = act.Search 'CurrentSelectionOrEmptyString' },
  { key = 'r', mods = 'CMD', action = act.ReloadConfiguration },

  -- Clipboard
  { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },

  -- Font size
  { key = '=', mods = 'CMD', action = act.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = act.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = act.ResetFontSize },
}

return config