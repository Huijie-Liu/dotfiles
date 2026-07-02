function mkcd
    mkdir -p $argv; and cd $argv
end

function proxy
    set -x http_proxy http://127.0.0.1:7890
    set -x https_proxy http://127.0.0.1:7890
    set -x all_proxy socks5://127.0.0.1:7890
    echo "Proxy ON: 127.0.0.1:7890"
end
