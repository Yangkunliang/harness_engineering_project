#!/bin/bash
# Harness Engineering - Agentic Workflow
# 智能体工作流总入口 - 全自动执行
# 用法: ./agentic-workflow.sh "你的需求描述"

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DEMAND="$1"
if [ -z "$DEMAND" ]; then
    echo -e "${RED}错误: 请提供需求描述${NC}"
    echo "用法: ./agentic-workflow.sh \"你的需求描述\""
    exit 1
fi

TASK_ID=$(date +%Y%m%d%H%M%S)
TASK_DIR=".harness/tasks/task-${TASK_ID}"
mkdir -p "$TASK_DIR"

MAX_RETRIES=3

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀  Harness Engineering - 智能体工作流启动${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}需求: ${DEMAND}${NC}"
echo -e "${YELLOW}任务ID: ${TASK_ID}${NC}"
echo ""

echo "$DEMAND" > "$TASK_DIR/demand.md"

# 阶段1: 需求分析 + 生成项目文档
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 01: 需求分析${NC}"
echo -e "${GREEN}   生成项目文档...${NC}"
./.harness/scripts/skill-01-demand-analysis.sh "$TASK_ID" "$DEMAND"

# 阶段2: 编码实现 + 自动提交
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 02: 编码实现${NC}"
echo -e "${GREEN}   生成代码并提交...${NC}"
./.harness/scripts/skill-02-implementation.sh "$TASK_ID"

# 阶段3: 专家评审
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 03: 专家评审${NC}"
./.harness/scripts/skill-03-expert-review.sh "$TASK_ID"

# 阶段4: 单元测试 + 反馈循环
ATTEMPT=1
while [ $ATTEMPT -le $MAX_RETRIES ]; do
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${GREEN}▶  Skill 04: 单元测试 (第${ATTEMPT}次)${NC}"

    if ./.harness/scripts/skill-04-unit-tests.sh "$TASK_ID"; then
        echo -e "${GREEN}✅  单元测试通过${NC}"
        break
    else
        echo -e "${RED}✗  单元测试失败${NC}"
        if [ $ATTEMPT -lt $MAX_RETRIES ]; then
            echo -e "${YELLOW}🔄  触发编码Skill自动修复...${NC}"
            ./.harness/scripts/skill-02-implementation.sh "$TASK_ID" --fix
            ATTEMPT=$((ATTEMPT + 1))
        else
            echo -e "${RED}❌  已达最大重试次数，流程终止${NC}"
            exit 1
        fi
    fi
done

# 阶段5: CI门禁
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 05: CI门禁${NC}"
./.harness/scripts/skill-05-ci-gate.sh "$TASK_ID"

# 阶段6: 部署验证
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 06: 部署验证${NC}"
./.harness/scripts/skill-06-deploy-verify.sh "$TASK_ID"

# 自动推送到Git
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  自动推送到Git仓库${NC}"
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
git add -A
git commit -m "feat(${TASK_ID}): ${DEMAND}" || echo "无需提交"
git push origin "$BRANCH" 2>/dev/null || echo "推送失败或无需推送"

# 生成最终验收报告
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  生成最终验收报告${NC}"
./.harness/scripts/generate-final-report.sh "$TASK_ID"

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅  智能体工作流执行完成！${NC}"
echo -e "${GREEN}📋  验收报告: ${TASK_DIR}/final-report.md${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"