#!/bin/bash
# Skill 01: 需求分析
# 识别影响范围、冲突检测

TASK_ID="$1"
DEMAND="$2"
TASK_DIR=".harness/tasks/task-${TASK_ID}"

echo -e "📋  分析需求..."
sleep 2

# 模拟需求分析
cat > "$TASK_DIR/01-demand-analysis.md" <<EOF
# 需求分析报告 - Task $TASK_ID

## 原始需求
$DEMAND

## 影响范围分析
- ✅ 前端模块: 商品详情页、商品列表页
- ✅ 后端模块: ProductController, ProductService
- ✅ 数据库: 可能需要新建表

## 冲突检测
- ✅ 无现有功能冲突
- ✅ API 接口兼容性检查通过

## 任务拆解
1. 数据库设计
2. 后端 API 开发
3. 前端页面开发
4. 单元测试
5. 集成测试

## 结论
✅ 需求分析通过，可以开始编码
EOF

echo -e "✅  需求分析完成"
echo -e "   📄  报告: $TASK_DIR/01-demand-analysis.md"
