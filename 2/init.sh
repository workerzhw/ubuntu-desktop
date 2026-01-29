# 注意！执行前请先下载 [noVNC](https://github.com/novnc/noVNC) 到当前目录！  
docker build -t ubuntu24.04-nodejs-vnc .  
docker rm -f pp_whv  
# 5911 vnc客户端端口，8888 noVNC 网页控制端口  
docker run --name pp_whv -d -p 5911:5901 -p 8888:8888 ubuntu24.04-nodejs-vnc
