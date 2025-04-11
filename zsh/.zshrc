# Enable Powerlevel10k instant prompt (should stay close to the top of ~/.zshrc)
# Initialization code that may require console input must go above this block
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# pyenv in PATH
case `uname` in
  Darwin)
    eval "$(pyenv init --path)"
    export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
  ;;
  Linux)
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
  ;;
esac

# nvm in PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Neovim in PATH (Linux only)
if [[ $(uname) == "Linux" ]]; then
  export PATH="$PATH:/opt/nvim/"
fi

# Initialize fzf (macOS only)
case `uname` in
  Darwin)
    source <(fzf --zsh)
  ;;
esac

### Oh-My-Zsh Configuration ###

# Path to Oh-My-Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
#  NOTE: zsh-syntax-highlighting must be last
plugins=(git
         fzf
         zsh-autosuggestions
         zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

### User Configuration ###

# Run `p10k configure` or edit ~/.p10k.zsh to customize prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Remove zsh-syntax-highlighting underlines from paths
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none

# Initialize opam
[[ ! -r '$HOME/.opam/opam-init/init.zsh' ]] || source '$HOME/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

# Initialize opam environment variables
eval $(opam env)
