ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit auto completions
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zsh plugins
zinit lucid for \
  light-mode zsh-users/zsh-autosuggestions \
  light-mode zsh-users/zsh-completions \
  light-mode zsh-users/zsh-syntax-highlighting \
  OMZP::git
