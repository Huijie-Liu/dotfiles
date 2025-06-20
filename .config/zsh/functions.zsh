# 创建目录并进入
function mkcd() {
    mkdir -p "$@" && cd "$1"
}

# 解压缩函数
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)          echo "'$1' 无法识别的文件类型" ;;
        esac
    else
        echo "'$1' 不是有效的文件"
    fi
}

# CUDA 版本管理功能
function cuda() {
    version=${1:-"11.8"}
    cuda_path=""
    
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "Usage: cuda [version]"
        echo "Available versions:"
        ls -1d /usr/local/cuda-* ~/.local/cuda-* 2>/dev/null | sed 's/.*cuda-//'
        return 0
    fi
    
    if [ ! -z "$CUDA_HOME" ]; then
        export PATH=$(echo $PATH | sed "s|$CUDA_HOME/bin:||g")
        export LD_LIBRARY_PATH=$(echo $LD_LIBRARY_PATH | sed "s|$CUDA_HOME/lib64:||g")
    fi
    
    if [ -d "/usr/local/cuda-$version" ]; then
        cuda_path="/usr/local/cuda-$version"
    elif [ -d "$HOME/.local/cuda-$version" ]; then
        cuda_path="$HOME/.local/cuda-$version"
    else
        echo "Warning: CUDA $version not found"
        return 1
    fi
    
    if [ ! -z "$cuda_path" ]; then
        export CUDA_VERSION="$version"
        export CUDA_HOME="$cuda_path"
        export PATH="$cuda_path/bin:$PATH"
        export LD_LIBRARY_PATH="$cuda_path/lib64:$LD_LIBRARY_PATH"
        echo "CUDA $version 已设置: $cuda_path"
        
        if command -v nvcc >/dev/null 2>&1; then
            nvcc --version | grep "release"
        fi
    fi
}

# CUDA 补全功能
function _cuda() {
    local -a versions
    
    if ! command -v cuda >/dev/null 2>&1; then
        return 1
    fi
    
    versions=(
        ${(f)"$(
            (
                [[ -d /usr/local ]] && find /usr/local -maxdepth 1 -name 'cuda-*' 2>/dev/null
                [[ -d ~/.local ]] && find ~/.local -maxdepth 1 -name 'cuda-*' 2>/dev/null
            ) | sed 's/.*cuda-//' | sort -u
        )"}
    )
    
    [[ -n "$versions" ]] || _message 'no cuda versions found'
    
    _describe 'cuda versions' versions
}

# 注册补全
compdef _cuda cuda

setcuda() {
  if [ $# -ne 1 ]; then
    echo "用法: setcuda <GPU编号>"
    echo "示例: setcuda 0,1"
    return 1
  fi
  export CUDA_VISIBLE_DEVICES="$1"
  echo "已设置 CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
}

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
