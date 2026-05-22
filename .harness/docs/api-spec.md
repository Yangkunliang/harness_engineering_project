# API 规范文档

## 认证接口

### POST /api/auth/login
登录接口

**请求体:**
```json
{
  "username": "string",
  "encryptedPassword": "string (RSA加密)"
}
```

**响应:**
```json
{
  "code": 200,
  "message": "登录成功",
  "data": {
    "token": "string",
    "tokenType": "Bearer",
    "expiresIn": 86400000,
    "user": {
      "id": "number",
      "username": "string",
      "realName": "string",
      "role": "string",
      "superAdmin": "boolean"
    }
  }
}
```

### GET /api/auth/public-key
获取RSA公钥

**响应:**
```json
{
  "code": 200,
  "data": { "publicKey": "string" }
}
```

## 用户管理接口

### GET /api/users
获取所有用户（需SUPER_ADMIN权限）

### POST /api/users
创建用户（需SUPER_ADMIN权限）

**请求体:**
```json
{
  "username": "string",
  "password": "string",
  "realName": "string",
  "phone": "string",
  "email": "string",
  "role": "ADMIN|USER"
}
```

### GET /api/users/{username}
根据用户名获取用户信息
