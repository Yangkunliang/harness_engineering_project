# 数据库设计文档

## sys_user 表

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 主键 |
| username | VARCHAR(50) | UNIQUE, NOT NULL | 用户名 |
| password | VARCHAR(255) | NOT NULL | 密码(BCrypt加密) |
| real_name | VARCHAR(100) | | 真实姓名 |
| phone | VARCHAR(20) | | 手机号 |
| email | VARCHAR(100) | | 邮箱 |
| role | VARCHAR(20) | NOT NULL | 角色 |
| enabled | BOOLEAN | NOT NULL DEFAULT TRUE | 是否启用 |
| account_non_locked | BOOLEAN | NOT NULL DEFAULT TRUE | 是否锁定 |
| account_non_expired | BOOLEAN | NOT NULL DEFAULT TRUE | 是否过期 |
| credentials_non_expired | BOOLEAN | NOT NULL DEFAULT TRUE | 凭证是否过期 |
| super_admin | BOOLEAN | NOT NULL DEFAULT FALSE | 是否超级管理员 |
| last_login_ip | VARCHAR(50) | | 最后登录IP |
| last_login_time | DATETIME | | 最后登录时间 |
| create_time | DATETIME | NOT NULL | 创建时间 |
| update_time | DATETIME | | 更新时间 |

## 角色说明

- SUPER_ADMIN: 超级管理员，拥有所有权限
- ADMIN: 管理员
- USER: 普通用户
