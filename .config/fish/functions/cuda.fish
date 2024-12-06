# CUDA 版本管理功能
function cuda --argument-names cmd --description "A customized manager for CUDA versions"
    # 根据子命令处理
    switch "$cmd"
        case "" -h --help
            echo "Usage: cuda [version]"
            echo "       cuda -v, --version  Print version"
            echo "       cuda -h, --help     Print this help message"
            echo "Available versions:"
            find /usr/local ~/.local -type d -name 'cuda-*' 2>/dev/null
            return 0

        case -v --version
            echo "CUDA version manager, version 1.0.0"
            return 0

        case "*"
            # 提取版本号或使用默认值
            set -l _version (string trim -c ' ' "$argv[1]")
            set -l cuda_path ""

            # 清理旧的 CUDA 环境变量
            if test -n "$CUDA_HOME"
                set PATH (string replace -r "$CUDA_HOME/bin:" "" $PATH)
                set LD_LIBRARY_PATH (string replace -r "$CUDA_HOME/lib64:" "" $LD_LIBRARY_PATH)
            end

            # 检查指定版本路径
            if test -d "/usr/local/cuda-$_version"
                set cuda_path "/usr/local/cuda-$_version"
            else if test -d "$HOME/.local/cuda-$_version"
                set cuda_path "$HOME/.local/cuda-$_version"
            else
                echo "Warning: CUDA $_version not found"
                return 1
            end

            # 设置环境变量
            if test -n "$cuda_path"
                set -x CUDA_VERSION "$_version"
                set -x CUDA_HOME "$cuda_path"
                set -x PATH "$cuda_path/bin:$PATH"
                set -x LD_LIBRARY_PATH "$cuda_path/lib64:$LD_LIBRARY_PATH"
                echo "CUDA $_version 已设置: $cuda_path"

                # 显示 nvcc 版本信息
                if command -v nvcc >/dev/null 2>&1
                    nvcc --version | grep -o "release [^,]*"
                else
                    echo "Warning: nvcc not found in the selected CUDA environment."
                end
            end
            return 0
    end
end