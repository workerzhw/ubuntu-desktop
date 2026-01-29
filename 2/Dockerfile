# 使用 Ubuntu 24.04 基础镜像
FROM ubuntu:24.04

# 更新包列表并安装工具
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    software-properties-common \
    sudo

# 添加 NodeSource 的签名密钥和 PPA 并安装 Node.js LTS 版本
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# 安装 Xfce 桌面环境和 VNC 服务器
RUN apt-get install -y xfce4 xfce4-goodies \
    tightvncserver \
    dbus-x11 \
    x11-xserver-utils

# 创建新用户并配置密码
RUN useradd -m -s /bin/bash vncuser && echo 'vncuser:password' | chpasswd && \
    usermod -aG sudo vncuser

# 复制当前文件夹下的 noVNC 文件夹到容器内的 /app 目录!
RUN mkdir /app
COPY noVNC /app/noVNC
RUN ls /app/noVNC/utils

# 根用户以复制启动脚本
USER root
COPY start_vnc.sh /usr/local/bin/start_vnc.sh
RUN chmod +x /usr/local/bin/start_vnc.sh

# 设置 VNC 服务器配置
USER vncuser
ENV USER=vncuser
RUN mkdir -p /home/vncuser/.vnc && \
    echo "password" | vncpasswd -f > /home/vncuser/.vnc/passwd && \
    chmod 600 /home/vncuser/.vnc/passwd && \
    echo "startxfce4 &" > /home/vncuser/.vnc/xstartup && \
    chmod +x /home/vncuser/.vnc/xstartup

# 暴露 VNC 端口
EXPOSE 5901

# 启动 VNC 服务器和 Xfce!
CMD ["/usr/local/bin/start_vnc.sh"]
