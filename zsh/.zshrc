# -- Environment & Paths
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export GOPATH=$HOME/go
export PATH="$PATH:/home/jesichi/.local/share/gem/ruby/3.4.0/bin:$GOPATH/bin"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

# -- Plugins
zinit ice wait lucid; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-history-substring-search
zinit ice wait lucid; zinit light Aloxaf/fzf-tab
zinit ice wait lucid; zinit light z-shell/zsh-zoxide

# -- History & Options
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups extended_glob
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# -- Aliases
alias zshconfig='nvim ~/.zshrc'
alias nvimconfig='cd ~/.config/nvim'
alias poshconfig='nvim ~/.config/ohmyposh/config.toml'
alias q='exit'
alias n='nvim'
alias c='clear'
alias cdd='cd ..'

# -- Completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# -- Theme (Oh-My-Posh)
if command -v oh-my-posh &>/dev/null; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"
fi
