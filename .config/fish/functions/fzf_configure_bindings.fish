function fzf_configure_bindings --description "Installs the default key bindings for fzf.fish with user overrides passed as options."
    # no need to install bindings if not in interactive mode or running tests
    status is-interactive || test "$CI" = true; or return

    if test $status -ne 0
        echo "Invalid option or a positional argument was provided." >&2
        return 22
    else
        # Initialize with default key sequences and then override or disable them based on flags
        # \c = control, \e = alt
        set -f key_sequences \ct \cr \ep \ev \er \t \ec

        for mode in default insert
            bind --mode $mode $key_sequences[1] _fzf_search_directory
            bind --mode $mode $key_sequences[2] _fzf_search_history
            bind --mode $mode $key_sequences[3] _fzf_search_processes
            bind --mode $mode $key_sequences[4] "$_fzf_search_vars_command"
            bind --mode $mode $key_sequences[5] _fzf_ripgrep
            bind --mode $mode $key_sequences[6] _fzf_complete
            bind --mode $mode $key_sequences[7] _fzf_zoxide
        end
    end
end
