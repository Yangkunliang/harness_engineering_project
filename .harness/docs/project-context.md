# 项目上下文

## 技术栈

- **后端:** Spring Boot 3.2.x, Java 21, Spring Security, JPA
- **前端:** Vue 3, TypeScript, Vite, Pinia
- **数据库:** MySQL 8.0
- **认证:** JWT + RSA加密

## 项目结构

```
backend/
├── src/main/java/com/harness/admin/
│   ├── config/          # 配置类
│   ├── controller/      # REST控制器
│   ├── dto/            # 数据传输对象
│   ├── entity/         # JPA实体
│   ├── repository/     # 数据访问层
│   ├── security/       # 安全相关(JWT, 过滤器)
│   ├── service/        # 业务逻辑
│   └── util/           # 工具类

frontend/
├── src/
│   ├── api/           # API调用
│   ├── router/        # 路由配置
│   ├── store/         # Pinia状态管理
│   ├── utils/         # 工具函数
│   └── views/         # 页面组件
```

## 安全机制

1. 登录密码在前端使用RSA公钥加密传输
2. 后端使用BCrypt存储密码
3. 认证使用JWT Token
4. 敏感接口需要SUPER_ADMIN权限
