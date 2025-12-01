# -- Inits
#
# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# linuxbrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# -- History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# pattern search
setopt extended_glob

# -- Bindings
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# -- Alias
alias zshconfig='nvim ~/.zshrc'
alias nvimconfig='cd ~/.config/nvim'
alias poshconfig='nvim ~/.config/ohmyposh/config.toml'
alias hyprconfig='cd ~/.config/hypr'
alias ghosttyconfig='nvim ~/.config/ghostty/config'
alias q='exit'
alias n='nvim'
alias c='clear'
alias cdd='cd ..'
# -- Plugins

# highlighting
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# autosuggestions
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# completions
zinit ice wait lucid
zinit light zsh-users/zsh-completions

# substring completions
zinit ice wait lucid
zinit light zsh-users/zsh-history-substring-search

# fzf-tab menu
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# zoxide (z command search)
zinit ice wait lucid
zinit light z-shell/zsh-zoxide

# -- Completions 
autoload -Uz compinit && compinit

# styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# homebrew completions
if type brew &>/dev/null; then
  FPATH="/home/linuxbrew/.linuxbrew/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# theme
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

