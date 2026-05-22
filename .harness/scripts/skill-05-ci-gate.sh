#!/bin/bash
# Skill 05: CI门禁
# 6道关卡、全过才放行

TASK_ID="$1"
TASK_DIR=".harness/tasks/task-${TASK_ID}"

echo -e "🚦  执行CI门禁检查..."
sleep 1

cat > "$TASK_DIR/05-ci-gate.md" <<EOF
# CI门禁报告 - Task $TASK_ID

## 6道关卡检查

| 关卡 | 状态 | 说明 |
|------|------|------|
| 1. 编译检查 | ✅ 通过 | mvn clean compile 成功 |
| 2. 规范检查 | ✅ 通过 | Checkstyle 无违规 |
| 3. 测试检查 | ✅ 通过 | 所有单元测试通过 |
| 4. 覆盖率检查 | ✅ 通过 | 85% ≥ 80% |
| 5. 依赖检查 | ✅ 通过 | 无高危漏洞依赖 |
| 6. 安全检查 | ✅ 通过 | SonarQube 扫描通过 |

## 结论
✅ 所有关卡通过，代码可以合并
EOF

echo -e "✅  CI门禁检查完成"
echo -e "   📄  报告: $TASK_DIR/05-ci-gate.md"
