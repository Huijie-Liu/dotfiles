function cuda --description "Switch CUDA versions"
    set -l version (count $argv) > 0 and echo $argv[1] or echo "11.8"
    set -l cuda_path ""

    if test "$argv[1]" = "-h" -o "$argv[1]" = "--help"
        echo "Usage: cuda [version]"
        echo "Available versions:"
        ls -1d /usr/local/cuda-* ~/.local/cuda-* 2>/dev/null | sed 's/.*cuda-//'
        return 0
    end

    if set -q CUDA_HOME
        set -p PATH (string replace "$CUDA_HOME/bin" "" $PATH)
        set -p LD_LIBRARY_PATH (string replace "$CUDA_HOME/lib64" "" $LD_LIBRARY_PATH)
    end

    if test -d "/usr/local/cuda-$version"
        set cuda_path "/usr/local/cuda-$version"
    else if test -d "$HOME/.local/cuda-$version"
        set cuda_path "$HOME/.local/cuda-$version"
    else
        echo "Warning: CUDA $version not found"
        return 1
    end

    if test -n "$cuda_path"
        set -x CUDA_VERSION "$version"
        set -x CUDA_HOME "$cuda_path"
        set -x PATH "$cuda_path/bin" $PATH
        set -x LD_LIBRARY_PATH "$cuda_path/lib64" $LD_LIBRARY_PATH
        echo "CUDA $version has been set to: $cuda_path"

        if command -v nvcc >/dev/null 2>&1
            nvcc --version | grep "release"
        end
    end
end
