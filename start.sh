#!/bin/sh

# 1. 强制设置工作目录
WORKDIR=$(pwd)
echo "当前工作目录: $WORKDIR"

# 2. 检查环境 (如果这里报错，说明 Dockerfile 没装好)
echo "检查工具..."
curl --version || echo "缺少 curl"
python3 --version || echo "缺少 python3"

# 3. 端口设置
REAL_PORT=${PORT:-3000}
echo "准备监听端口: $REAL_PORT"

# 4. 启动伪装网页 (改用更稳健的监听方式)
mkdir -p ./web
echo "<h1>System Active</h1>" > ./web/index.html
# 必须使用 0.0.0.0 绑定
python3 -m http.server $REAL_PORT --bind 0.0.0.0 --directory ./web > python_server.log 2>&1 &
echo "Python 网页服务已尝试在后台启动"

# 5. 下载哪吒客户端
echo "正在下载 nezha-agent..."
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] && URL_ARCH="amd64" || URL_ARCH="arm64"

# 增加 -f 报错检查
curl -L -f "https://github.com/nezhahq/agent/releases/latest/download/nezha-agent_linux_${URL_ARCH}.zip" -o agent.zip || { echo "下载失败"; exit 1; }
unzip -o agent.zip
chmod +x nezha-agent

# 6. 写入配置文件
cat <<EOF > config.yml
client_secret: "p3joFK1jc3Z31YXqMXfNPvjjxx1lQknL"
debug: false
server: "nz.117.de5.net:443"
tls: true
EOF

# 7. 最终运行 (这是前台进程，绝对不能加 &)
echo "启动哪吒客户端..."
./nezha-agent run -c config.yml
