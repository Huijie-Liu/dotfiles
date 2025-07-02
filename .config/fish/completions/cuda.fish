function __fish_cuda_complete
    set -l versions (
        (
            if test -d /usr/local; find /usr/local -maxdepth 1 -name 'cuda-*' 2>/dev/null; end
            if test -d ~/.local; find ~/.local -maxdepth 1 -name 'cuda-*' 2>/dev/null; end
        ) | sed 's/.*cuda-//' | sort -u
    )

    for version in $versions
        complete -c cuda -a $version
    end
end

__fish_cuda_complete
