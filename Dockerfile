# 使用Node.js 20 LTS版本作为基础镜像（与工作流保持一致）
FROM node:20-alpine

# 设置工作目录
WORKDIR /app

# 安装pnpm包管理器
RUN npm install -g pnpm

# 复制package.json和pnpm-lock.yaml文件
COPY backend/package.json backend/pnpm-lock.yaml ./

# 如果存在patches目录，也复制过来
COPY backend/patches ./patches

# 安装依赖（使用--no-frozen-lockfile选项，与工作流保持一致）
RUN pnpm install --no-frozen-lockfile

# 复制backend源代码
COPY backend/ ./

# 执行打包构建（使用bundle:esbuild，与工作流保持一致）
RUN pnpm run bundle:esbuild

# 暴露端口3000
EXPOSE 3000

# 设置环境变量
ENV NODE_ENV=production
ENV SUB_STORE_BACKEND_API_PORT=3000
ENV SUB_STORE_BACKEND_API_HOST=0.0.0.0

# 启动应用
CMD ["node", "sub-store.min.js"]