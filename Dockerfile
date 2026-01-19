# 使用 Debian 版本的镜像以便安装系统工具  ← 注释掉或删除这行说明
FROM node:22-alpine

# 安装脚本运行所需的工具（Alpine 用 apk）
RUN apk update --no-cache && \
    apk add --no-cache curl unzip python3 py3-pip && \
    rm -rf /var/cache/apk/*

WORKDIR /app

# 拷贝所有文件
COPY . .

# 赋予脚本执行权限
RUN chmod +x start.sh

# 启动 (推荐通过 sh 直接运行)
CMD ["sh", "./start.sh"]
