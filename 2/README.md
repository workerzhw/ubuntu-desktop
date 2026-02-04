## 共用宿主机uid gid

### 1. create
```sh
docker run -it --rm \
  --name zb-cc \
  --hostname $(hostname) \
  --gpus all \
  -p 11020-11022:9090-9092 \
  -v $PWD:/cv \
  -w /cv \
  docker.m.daocloud.io/nvidia/cuda:12.4.0-base-ubuntu22.04

```
```sh
docker run -itd \
  --restart always \
  --name zb-cc \
  --hostname H4 \
  -p 11030-11032:5900-5902 \
  -v $PWD:/cv \
  ubuntu:22.04
```

### 2. run
```sh
docker exec -it -u root zb-cc /bin/bash -c "
    # 非交互安装sudo，清理缓存
    DEBIAN_FRONTEND=noninteractive apt update && apt install -y sudo && apt clean;
    # 动态获取宿主机用户名、UID、GID（无需手动修改）
    USER_NAME=$(whoami) && USER_UID=$(id -u) && USER_GID=$(id -g);
    # 1. 创建匹配GID的用户组（-f 避免组已存在报错）
    groupadd -f -g \$USER_GID \$USER_NAME;
    # 2. 创建匹配UID/GID/用户名的用户，带主目录和bash
    useradd -m -u \$USER_UID -g \$USER_GID -s /bin/bash \$USER_NAME;
    # 3. 为用户设置密码，绕过sudo密码校验
    echo \"\${USER_NAME}:\${USER_NAME}\" | chpasswd;
    # 4. 配置免密sudo，严格设置文件权限0440（sudo强制要求）
    echo \"\${USER_NAME} ALL=(ALL) NOPASSWD: ALL\" > /etc/sudoers.d/\$USER_NAME;
    chmod 0440 /etc/sudoers.d/\${USER_NAME};
    # 5. 完整切换用户环境（加载$HOME、PATH等环境变量）
    su - \$USER_NAME
  "
```

