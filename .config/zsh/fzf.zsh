[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)
# 检查命令是否存在的函数
command_exists() {
  command -v "$1" >/dev/null 2>&1
}
# 设置用于预览文件的命令
if command_exists bat; then
  export FZF_PREVIEW_FILE_CMD='bat --style=numbers --color=always {} | head -500'
else
  export FZF_PREVIEW_FILE_CMD='cat {} | head -500'
fi
# 设置用于预览目录的命令
if command_exists eza; then
  export FZF_PREVIEW_DIR_CMD='eza -la --color=always --no-filesize --icons=always --no-time --no-user --no-permissions {} | head -200'
else
  export FZF_PREVIEW_DIR_CMD='ls -la --color=always {} | head -200'
fi
export FZF_PREVIEW_OPTS="
  --preview='([[ -d {} ]] && $FZF_PREVIEW_DIR_CMD) || ($FZF_PREVIEW_FILE_CMD) 2> /dev/null'
  --preview-window=right:50%:border-rounded
"
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border=rounded
  --border-label=''
  --prompt='> '
  --marker='>'
  --pointer='◆'
  --separator='─'
  --scrollbar='│'
"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS $FZF_PREVIEW_OPTS"