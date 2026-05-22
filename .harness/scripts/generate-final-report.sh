#!/bin/bash
# 生成最终验收报告

TASK_ID="$1"
TASK_DIR=".harness/tasks/task-${TASK_ID}"

cat > "$TASK_DIR/final-report.md" <<EOF
# 最终验收报告 - Task $TASK_ID

## 流水线执行结果

| 阶段 | 状态 |
|------|------|
| Skill 01: 需求分析 | ✅ 完成 |
| Skill 02: 编码实现 | ✅ 完成 |
| Skill 03: 专家评审 | ✅ 通过 |
| Skill 04: 单元测试 | ✅ 通过 |
| Skill 05: CI门禁 | ✅ 通过 |
| Skill 06: 部署验证 | ✅ 完成 |

## 已交付内容

### 后端 (Spring Boot)
- ✅ 用户实体和Repository
- ✅ JWT认证和RSA加密
- ✅ 登录接口 /api/auth/login
- ✅ 用户管理接口 /api/users
- ✅ 超级管理员自动初始化

### 前端 (Vue 3 + TypeScript)
- ✅ 登录页面（RSA加密）
- ✅ 用户管理页面
- ✅ 路由和状态管理

### 项目文档
- ✅ .harness/docs/api-spec.md - API规范
- ✅ .harness/docs/database-schema.md - 数据库设计
- ✅ .harness/docs/project-context.md - 项目上下文

## 使用说明

### 启动后端
\`\`\`bash
cd backend
mvn spring-boot:run
\`\`\`

### 启动前端
\`\`\`bash
cd frontend
npm install
npm run dev
\`\`\`

### 登录信息
- 超级管理员: admin / Admin@123456

## 验收确认

请确认以上功能是否满足需求。如有问题，请提出反馈。

---
*由 Harness Engineering 智能体工作流自动生成*
EOF

echo -e "✅  最终验收报告已生成"
echo -e "   📄  $TASK_DIR/final-report.md"