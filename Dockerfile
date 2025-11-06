FROM kasmweb/core-ubuntu-jammy:1.13.0

LABEL version="1.0" maintainer="colinchang<zhangcheng5468@gmail.com>"

USER root

# 替换阿里云系统源
COPY $PWD/sources.list /etc/apt/sources.list
RUN apt update && mkdir -p /home/kasm-user/Desktop \

# Chrome
&& apt install -y xdg-utils fonts-liberation libu2f-udev \
&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
&& dpkg -i google-chrome-stable_current_amd64.deb \
&& sed -i 's/Exec=\/usr\/bin\/google-chrome-stable/Exec=\/usr\/bin\/google-chrome-stable --no-sandbox/g' /usr/share/applications/google-chrome.desktop \
&& ln -s /usr/share/applications/google-chrome.desktop /home/kasm-user/Desktop/google-chrome.desktop \

# Thunder
&& apt install -y libgtk2.0-0 libdbus-glib-1-2 \

# Visual Studio Code
&& wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/1a5daa3a0231a0fbba4f14db7ec463cf99d7768e/code_1.84.2-1699528352_amd64.deb \
&& dpkg -i code_1.84.2-1699528352_amd64.deb \
&& sed -i 's/Exec=\/usr\/share\/code\/code/Exec=\/usr\/share\/code\/code --no-sandbox/g' /usr/share/applications/code.desktop \
&& sed -i 's/Icon=com.visualstudio.code/Icon=\/usr\/share\/code\/resources\/app\/resources\/linux\/code.png/g' /usr/share/applications/code.desktop \
&& ln -s /usr/share/applications/code.desktop /home/kasm-user/Desktop/code.desktop \

&& apt autoremove -y \
&& apt clean \
&& rm -rf *.deb
