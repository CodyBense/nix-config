HISTFILE=~/.cache/history
HISTSIZE=1000
SAVEHIST=1000

export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export MANPAGER='nvim +Man!'
. "$HOME/.cargo/env"

# aliases
alias c="clear"
alias v="nvim"
alias vi="nvim"
alias iv='nvim $(fzf --preview="bat --color=always {}")'
alias sv="sudo nvim"
alias ll="ls -l"
alias la="ls -la"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias mkdir="mkdir -p"
alias ib='bat $(fzf --preview="bat --color=always {}")'
alias ".."="cd .."
alias "2."="cd ../.."
alias "3."="cd ../../.."
alias "4."="cd ../../../.."
alias py="python3"
alias lg="lazygit"
alias zj="zellij"
alias zja="zellij attach"

# flatpak aliases
# alias yazi="flatpak run io.github.sxyazi.yazi"

# scripts
export PATH=$PATH:$HOME/bin

# pipx
export PATH="$PATH:/home/codybense/.local/bin"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - bash)"

# evals
eval "$(fzf --bash)"
eval "$(starship init bash)"
eval "$(direnv hook bash)"
eval "$(zoxide init bash)"
