function proxy_on
    set -x http_proxy "http://127.0.0.1:17890"
    set -x https_proxy "http://127.0.0.1:17890"
    export http_proxy
    export https_proxy
    echo "代理已开启"
end

function proxy_off
    if set -q http_proxy
        set -e http_proxy
        set -e https_proxy
        echo "代理已关闭"
    else
        echo "代理未开启"
    end
end