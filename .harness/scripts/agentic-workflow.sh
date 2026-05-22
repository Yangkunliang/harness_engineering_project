#!/bin/bash
# Harness Engineering - Agentic Workflow
# 智能体工作流总入口，支持自动反馈循环
# 用法: ./agentic-workflow.sh "你的需求描述"

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 需求描述
DEMAND="$1"
if [ -z "$DEMAND" ]; then
    echo -e "${RED}错误: 请提供需求描述${NC}"
    echo "用法: ./agentic-workflow.sh \"你的需求描述\""
    exit 1
fi

# 任务ID
TASK_ID=$(date +%Y%m%d%H%M%S)
TASK_DIR=".harness/tasks/task-${TASK_ID}"
mkdir -p "$TASK_DIR"

# 最大重试次数
MAX_RETRIES=3

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀  Harness Engineering - 智能体工作流启动"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}需求: ${DEMAND}${NC}"
echo -e "${YELLOW}任务ID: ${TASK_ID}${NC}"
echo ""

# 记录需求
echo "$DEMAND" > "$TASK_DIR/demand.md"

# 初始化尝试次数
ATTEMPT=1

# 反馈循环函数
run_with_feedback_loop() {
    local step_name="$1"
    local step_script="$2"
    local step_args="$3"
    local fail_action="$4"

    while true; do
        echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
        echo -e "${GREEN}▶  ${step_name}${NC}"
        
        if $step_script $step_args; then
            echo -e "${GREEN}✅  ${step_name}通过${NC}"
            return 0
        else
            echo -e "${RED}✗  ${step_name}失败${NC}"
            
            if [ "$fail_action" == "retry_coding" ]; then
                if [ $ATTEMPT -lt $MAX_RETRIES ]; then
                    ATTEMPT=$((ATTEMPT + 1))
                    echo -e "${YELLOW}🔄  第${ATTEMPT}次尝试：触发编码Skill自动修复...${NC}"

                    # 更新任务报告
                    echo "" >> "$TASK_DIR/final-report.md"
                    echo "**第${ATTEMPT}次迭代**: ${step_name}失败，触发编码Skill自动修复" >> "$TASK_DIR/final-report.md"

                    # 调用编码Skill修复（使用 --fix 模式）
                    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
                    echo -e "${GREEN}▶  Skill 02: 编码实现（自动修复模式）${NC}"
                    ./.harness/scripts/skill-02-implementation.sh "$TASK_ID" --fix
                    continue
                else
                    echo -e "${RED}❌  已达到最大重试次数（${MAX_RETRIES}），流程终止${NC}"
                    return 1
                fi
            else
                echo -e "${RED}❌  流程终止，请检查问题${NC}"
                return 1
            fi
        fi
    done
}

# 步骤1: 需求分析
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 01: 需求分析${NC}"
./.harness/scripts/skill-01-demand-analysis.sh "$TASK_ID" "$DEMAND"

# 步骤2: 编码实现
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 02: 编码实现${NC}"
./.harness/scripts/skill-02-implementation.sh "$TASK_ID"

# 步骤3: 专家评审
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 03: 专家评审${NC}"
./.harness/scripts/skill-03-expert-review.sh "$TASK_ID"

# 步骤4: 单元测试（带反馈循环）
echo ""
run_with_feedback_loop "Skill 04: 单元测试" "./.harness/scripts/skill-04-unit-tests.sh" "$TASK_ID" "retry_coding"

# 步骤5: CI门禁
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 05: CI门禁${NC}"
./.harness/scripts/skill-05-ci-gate.sh "$TASK_ID"

# 步骤6: 部署验证
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  Skill 06: 部署验证${NC}"
./.harness/scripts/skill-06-deploy-verify.sh "$TASK_ID"

# 生成最终验收报告
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}▶  生成最终验收报告${NC}"
./.harness/scripts/generate-final-report.sh "$TASK_ID"

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅  智能体工作流执行完成！"
echo -e "${GREEN}📋  请查看验收报告: ${TASK_DIR}/final-report.md"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"