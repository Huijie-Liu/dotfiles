# FZF 初始化
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# FZF 变量搜索配置
export _fzf_search_vars_command='_fzf_search_variables (set | psub) (set | cut -d= -f1 | psub)'
