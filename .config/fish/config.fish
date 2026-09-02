set fish_greeting

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

function fish_user_key_bindings
    bind enter accept-autosuggestion execute
    bind escape suppress-autosuggestion cancel
end
