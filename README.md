# Harness Admin System

企业级后台管理系统，提供安全的账号管理功能。

## 技术栈

### 后端
- Java 1.8
- Spring Boot 2.7.18
- Spring Security
- JWT + RSA 加密
- SQLite 数据库

### 前端
- Vue 3 + TypeScript
- Vue Router
- Pinia (状态管理)
- Vite
- Tailwind CSS 3

## 快速开始

### 环境要求
- JDK 1.8+
- Maven 3.6+
- Node.js 18+

### 启动后端

```bash
cd backend
mvn spring-boot:run
```

后端服务将在 `http://localhost:8080` 启动

### 启动前端

```bash
cd frontend
npm install
npm run dev
```

前端服务将在 `http://localhost:5173` 启动

### 构建生产版本

```bash
# 后端打包
cd backend
mvn clean package

# 前端构建
cd frontend
npm run build
```

## 项目结构

```
.
├── backend/                 # Spring Boot 后端
│   ├── src/main/java/       # Java 源代码
│   ├── src/main/resources/  # 配置文件
│   └── pom.xml              # Maven 依赖
├── frontend/                # Vue 3 前端
│   ├── src/                 # 源代码
│   ├── index.html           # HTML 入口
│   └── package.json         # npm 依赖
└── .harness/               # Harness Engineering 配置
    ├── scripts/            # 工作流脚本
    ├── docs/               # 项目文档
    └── changes/            # 变更记录
```

## API 接口

### 认证接口
| 方法 | 路径 | 描述 |
|------|------|------|
| POST | `/api/auth/login` | 用户登录 |
| GET | `/api/auth/public-key` | 获取公钥 |

### 用户管理接口
| 方法 | 路径 | 描述 |
|------|------|------|
| POST | `/api/users` | 创建用户 |
| GET | `/api/users` | 获取用户列表 |
| GET | `/api/users/{username}` | 获取用户详情 |

## 默认登录信息

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 超级管理员 | admin | Admin@123456 |

## 安全特性

- ✅ RSA 非对称加密传输密码
- ✅ JWT 无状态认证
- ✅ BCrypt 密码哈希存储
- ✅ 基于角色的访问控制

## 许可证

MIT License