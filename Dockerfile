# 使用 Debian 版本的镜像以便安装系统工具
FROM node:22-bullseye-slim

# 安装脚本运行所需的工具
RUN apt-get update && \
    apt-get install -y curl unzip python3 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 拷贝所有文件
COPY . .

# 赋予脚本执行权限
RUN chmod +x start.sh

# 启动 (推荐通过 sh 直接运行)
CMD ["sh", "./start.sh"]
