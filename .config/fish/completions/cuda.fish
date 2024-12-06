function _cuda
    # 查找 CUDA 版本路径
    set -l versions
    set versions (find /usr/local ~/.local $CUDA_HOME -type d -name 'cuda-*' 2>/dev/null | string replace -r '.*cuda-' '' | sort -u)

    # 输出每个版本号
    for _version in $versions
        echo $_version
    end
end

complete --command cuda --exclusive --arguments "(_cuda)"