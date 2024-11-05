# Zinit 安装检查
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing zinit...%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 延迟加载插件
zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait'1' lucid
zinit light zsh-users/zsh-completions

# syntax-highlighting 应该最后加载
zinit ice wait'2' lucid
zinit light zsh-users/zsh-syntax-highlighting

# 加载 oh-my-zsh 的 git 插件
zinit snippet OMZ::plugins/git/git.plugin.zsh

# 其他工具加载
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"