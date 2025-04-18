# 使用 OpenJDK 17 作为基础镜像
FROM eclipse-temurin:17-jdk
# RUN apt-get update
# RUN apt-get install -y libaio* &&\
# RUN apt-get update &&\
#     apt-get install -y libaio* &&\
#     rm -rf /var/lib/apt/lists/* && apt-get clean &&\
#     cd /usr/lib/x86_64-linux-gnu/ &&\
#     ln -s libaio.so.1t64.0.2 libaio.so.1 &&\
#     ln -s libncursesw.so.6.4 libncurses.so.6

# 设置工作目录
WORKDIR /app

# 将项目依赖复制到镜像中
COPY lib ./lib
COPY conf ./conf
COPY hybench README.md ./

# 启动应用
CMD ["/bin/bash","-c","cat /app/README.md"]
