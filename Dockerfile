# 使用 OpenJDK 17 作为基础镜像
FROM eclipse-temurin:17-jdk

# 设置工作目录
WORKDIR /app

# 将项目依赖复制到镜像中
COPY lib ./lib
COPY conf ./conf
COPY hybench README.md ./

# 启动应用
CMD ["/bin/bash","-c","cat /app/README.md"]