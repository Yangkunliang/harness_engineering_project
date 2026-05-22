# Harness Engineering 项目宪法

---

## 一、项目定位

**Harness Engineering** - AI驱动的智能开发框架

通过约束、反馈回路和控制系统确保 Agent 可靠工作，类比为"给马造一条高速公路，配上护栏、限速牌和加油站"。

### 三次AI工程范式跃迁

1. **提示词工程** - 对马喊话的技巧
2. **上下文工程** - 给马看的地图
3. **驾驭工程** - 给马造高速公路

---

## 二、五层架构

### 1. 入口层 (CLAUDE.md)
项目宪法，定义红线和索引

### 2. 规则层 (rules/)
编码规范、开发流程（阿里巴巴Java开发手册）

### 3. 技能层 (skills/)
六大核心开发流水线：
- 01-需求分析
- 02-编码实现
- 03-专家评审
- 04-单元测试
- 05-CI门禁
- 06-部署验证

### 4. 知识层 (wiki/)
业务模型、接口协议、数据模型、领域术语

### 5. 记录层 (changes/)
变更追踪

---

## 三、文件索引

### Harness配置目录
- `.harness/rules/` - 规则层
  - `coding-standards/` - 编码规范（阿里巴巴Java开发手册、Vue编码规范）
  - `process/` - 开发流程
- `.harness/skills/` - 技能层：六大核心开发流水线
  - `01-需求分析.md` - 识别影响范围、冲突检测、任务拆解
  - `02-编码实现.md` - 遵循6步法、自检清单
  - `03-专家评审.md` - 6维评审、阻断机制
  - `04-单元测试.md` - 覆盖率≥80%、核心100%
  - `05-CI门禁.md` - 6道关卡、全过才放行
  - `06-部署验证.md` - 冒烟+性能测试
- `.harness/scripts/` - 智能体工作流（可执行脚本）
  - `agentic-workflow.sh` - 工作流总入口
  - `skill-01-demand-analysis.sh` - 需求分析
  - `skill-02-implementation.sh` - 编码实现
  - `skill-03-expert-review.sh` - 专家评审
  - `skill-04-unit-tests.sh` - 单元测试
  - `skill-05-ci-gate.sh` - CI门禁
  - `skill-06-deploy-verify.sh` - 部署验证
  - `generate-final-report.sh` - 生成验收报告
- `.harness/wiki/` - 知识层
- `.harness/changes/` - 记录层
- `.harness/INIT.md` - 项目初始化报告
- `.claude/` - AI Agent配置

### Docker配置
- `docker-compose.yml` - 容器编排
- `Dockerfile.backend` - 后端容器配置
- `Dockerfile.frontend` - 前端容器配置

---

## 四、红线规则

### 🚫 严禁事项
1. 业务代码不得存在于架构配置目录之外
2. 禁止手动修改已通过CI的代码
3. 禁止绕过Skills流水线直接提交代码
4. 禁止提交包含敏感信息（密钥、密码）的代码

### ✅ 必须事项
1. 所有需求必须通过智能体工作流处理
2. 所有代码必须通过6大流水线检查
3. 所有部署必须通过冒烟测试
4. 所有变更必须记录在changes目录

---

## 五、智能体工作流

### 🚀 使用方式

**你只需要做一件事：**
在对话中提出需求（如："我要一个用户注册功能"）

**AI自动执行：**
1. Skill 01: 需求分析
2. Skill 02: 编码实现
3. Skill 03: 专家评审
4. Skill 04: 单元测试
5. Skill 05: CI门禁
6. Skill 06: 部署验证
7. 生成验收报告

**你最后只需要：**
✅ 查看验收报告 → 确认上线

### 手动触发方式
```bash
./.harness/scripts/agentic-workflow.sh "你的需求描述"
```

---

## 六、质量标准

| 指标 | 目标 |
|------|------|
| 单元测试覆盖率 | ≥ 80% |
| 核心模块覆盖率 | 100% |
| 性能(QPS) | ≥ 1000 |
| API响应时间 | < 200ms |
| 错误率 | < 0.1% |

---

## 七、技术栈

### 后端（待通过流水线生成）
- Java 21 / Spring Boot 3.2.x
- Spring Data JPA / MySQL 8.0+
- Spring Security / JWT

### 前端（待通过流水线生成）
- Vue 3 + TypeScript
- Pinia / Vue Router
- Element Plus

---

## 八、项目状态

**状态**: 🚀 已初始化，从0开始

**业务代码**: 无（等待通过 Skills 流水线生成）

**Git远程**: https://github.com/Yangkunliang/harness_engineering_project

---

*最后更新: 2026-05-22*
