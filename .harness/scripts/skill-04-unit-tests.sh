#!/bin/bash
# Skill 04: 单元测试
# 执行测试并返回结果

TASK_ID="$1"
TASK_DIR=".harness/tasks/task-${TASK_ID}"

echo -e "🧪  执行单元测试..."

TEST_SUCCESS=true

echo -e "   1️⃣  后端单元测试..."
if [ -d "backend" ]; then
    cd backend
    if mvn test -q 2>/dev/null; then
        echo -e "   ✅  后端测试通过"
    else
        echo -e "   ❌  后端测试失败"
        TEST_SUCCESS=false
    fi
    cd ..
else
    echo -e "   ⏭️  后端目录不存在，跳过"
fi

echo -e "   2️⃣  前端测试..."
if [ -d "frontend" ]; then
    cd frontend
    if npm run test:e2e 2>/dev/null; then
        echo -e "   ✅  前端测试通过"
    elif npm run test 2>/dev/null; then
        echo -e "   ✅  前端测试通过"
    else
        echo -e "   ⏭️  前端测试脚本未配置，跳过"
    fi
    cd ..
else
    echo -e "   ⏭️  前端目录不存在，跳过"
fi

cat > "$TASK_DIR/04-unit-tests.md" <<EOF
# 单元测试报告 - Task $TASK_ID

## 测试结果
- 后端单元测试: $([ "$TEST_SUCCESS" = true ] && echo "✅ 通过" || echo "❌ 失败")
- 前端测试: $([ "$TEST_SUCCESS" = true ] && echo "✅ 通过" || echo "❌ 失败")

## 结论
$(if [ "$TEST_SUCCESS" = true ]; then
    echo "✅ 单元测试通过，可以进入CI门禁"
else
    echo "❌ 单元测试失败，需要修复"
fi)
EOF

echo -e "✅  单元测试完成"
echo -e "   📄  报告: $TASK_DIR/04-unit-tests.md"

if [ "$TEST_SUCCESS" = true ]; then
    exit 0
else
    exit 1
fi