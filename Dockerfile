# 使用一个官方的、轻量的 Python 3.11 镜像作为基础
FROM python:3.11-slim

# 在容器内部创建一个工作目录 /app
WORKDIR /app

# 先将 requirements.txt 复制进去，并安装依赖
# 这一步可以利用 Docker 的缓存机制，如果依赖不变，下次构建会更快
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 将项目中的所有其他文件复制到容器的 /app 目录中
COPY . .

# 告诉 Docker，我们的应用将监听 5102 端口
EXPOSE 5102

# 容器启动时要执行的命令
# 使用 0.0.0.0 让服务可以被外部访问
CMD ["uvicorn", "api_server:app", "--host", "0.0.0.0", "--port", "5102"]