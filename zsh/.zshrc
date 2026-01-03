# -- Environment & Paths

# Homebrew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && {
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
}
source "${ZINIT_HOME}/zinit.zsh"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Language environments
export GOPATH="$HOME/go"
export GEM_HOME="$HOME/.local/share/gem/ruby/3.4.0"
export GEM_PATH="$GEM_HOME"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"

# PATH
export PATH="$GEM_HOME/bin:$JAVA_HOME/bin:$GOPATH/bin:$PATH"


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
