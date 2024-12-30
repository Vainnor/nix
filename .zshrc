export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.dotfiles"

eval "$(zoxide init zsh)"
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands


#theme
ZSH_THEME="geoffgarside"


# zinit plugins


#Other plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

alias vim="nvim"
alias lg="lazygit"
alias gs="git status"
alias gi="git init"
alias gd="git diff"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gp="git push"
alias gpu="git pull"
alias gck="git checkout"
alias cd="z"
alias ff="fastfetch"
alias moo="cowsay I use macOS btw"
alias rbd="darwin-rebuild switch --flake ~/nix#vainnor-mac"
alias rbh="home-manager switch --flake ~/nix#vainnor@vainnor-mac"
alias ipaddress='ifconfig | grep -A 5 en0 | grep "inet " | cut -f2 -d " "' # User configuration export MANPATH="/usr/local/man:$MANPATH"
alias o='cd ~/Documents/Vault\ V5/'
alias hm='cd ~/'

HISTSIZE=5000
HISTFILE=~/.zsh_history

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
