# fzf.fish is only meant to be used in interactive mode. If not in interactive mode and not in CI, skip the config to speed up shell startup
if not status is-interactive && test "$CI" != true
    exit
end

set --global _fzf_search_vars_command '_fzf_search_variables (set --show | psub) (set --names | psub)'

fzf_configure_bindings
