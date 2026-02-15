# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git auto-notify)

# Show last 3 directories in path
prompt_dir() {
  local dir_path="${PWD/#$HOME/~}"
  local path_parts=(${(s:/:)dir_path})
  
  if [[ ${#path_parts[@]} -gt 3 ]]; then
    echo "${path_parts[-3]}/${path_parts[-2]}/${path_parts[-1]}"
  else
    echo "$dir_path"
  fi
}

source $ZSH/oh-my-zsh.sh

PROMPT='%F{green}➜  %B%F{cyan}$(prompt_dir)%f $(git_prompt_info)'

# Ignore certain commands
export AUTO_NOTIFY_IGNORE=("docker" "vim" "man" "less")

# Notification title/body format
export AUTO_NOTIFY_TITLE="Done: %command"
export AUTO_NOTIFY_BODY="Finished in %elapsed seconds"

[ -f ~/.zshrc_secrets ] && source ~/.zshrc_secrets

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias ddocker="brew services start colima"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
fpath=(~/.docker/completions \/Users/erijox/.oh-my-zsh/plugins/git /Users/erijox/.oh-my-zsh/functions /Users/erijox/.oh-my-zsh/completions /Users/erijox/.oh-my-zsh/custom/functions /Users/erijox/.oh-my-zsh/custom/completions /Users/erijox/.oh-my-zsh/cache/completions /usr/local/share/zsh/site-functions /usr/share/zsh/site-functions /usr/share/zsh/5.9/functions)
autoload -Uz compinit
compinit
export PATH="$HOME/.local/bin:$PATH"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down