#!/bin/bash
# 这是一个设置和取消 Git 代理的脚本
# 1. 赋予执行权限 
#    chmod +x git_proxy.sh
# 2. 设置代理
#        ./git_proxy.sh set <proxy_address> <proxy_port>
#    例：./git_proxy.sh set 192.168.1.1 8080
#    取消代理
#       ./git_proxy.sh unset

# 检查是否提供了参数
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 {set|unset} [proxy_address] [proxy_port]"
    exit 1
fi

# 解析参数
ACTION=$1
PROXY_ADDRESS=$2
PROXY_PORT=$3

case $ACTION in
    set)
        if [ -z "$PROXY_ADDRESS" ] || [ -z "$PROXY_PORT" ]; then
            echo "Error: Proxy address and port must be provided when setting the proxy."
            exit 1
        fi
        echo "Setting HTTP and HTTPS proxy to http://$PROXY_ADDRESS:$PROXY_PORT"
        git config --local http.proxy http://$PROXY_ADDRESS:$PROXY_PORT
        git config --local https.proxy https://$PROXY_ADDRESS:$PROXY_PORT
        ;;
    unset)
        echo "Unsetting HTTP and HTTPS proxy"
        git config --unset --local http.proxy
        git config --unset --local https.proxy
        ;;
    *)
        echo "Invalid action: $ACTION"
        echo "Usage: $0 {set|unset} [proxy_address] [proxy_port]"
        exit 1
        ;;
esac