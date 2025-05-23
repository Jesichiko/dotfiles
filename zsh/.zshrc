# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# History
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

# Keybindings 
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Aliases
alias c='clear'
alias zshconfig='nvim ~/.zshrc'
alias nvimconfig='cd ~/.config/nvim'
alias poshconfig='nvim ~/.config/ohmyposh/config.toml'
alias hyprconfig='cd ~/.config/hypr'
alias ghosttyconfig='nvim ~/.config/ghostty/config'
alias cdd='cd ..'
alias q='exit'

# plugins 
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Completions 
autoload -Uz compinit && compinit

# Styles
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# zoxide
zinit ice wait lucid
zinit light z-shell/zsh-zoxide

# Theme
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# yazi editor
export EDITOR=nvim

export PATH=$PATH:/home/jesichi/.spicetify
