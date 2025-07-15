# 使用Node.js 18 LTS版本作为基础镜像
FROM node:18-alpine

# 设置工作目录
WORKDIR /app

# 安装pnpm包管理器
RUN npm install -g pnpm

# 复制package.json和pnpm-lock.yaml到工作目录
COPY backend/package.json backend/pnpm-lock.yaml ./

# 安装依赖
RUN pnpm install --frozen-lockfile

# 复制backend源代码
COPY backend/ ./

# 暴露端口3000
EXPOSE 3000

# 设置环境变量
ENV NODE_ENV=production
ENV SUB_STORE_BACKEND_API_PORT=3000
ENV SUB_STORE_BACKEND_API_HOST=::

# 启动应用
CMD ["pnpm", "start"]
