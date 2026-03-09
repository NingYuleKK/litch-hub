---

# Agent Onboarding Checklist

每次新开协作窗口时，agent 必须先读完以下文档再开始工作。

## 所有 Agent 通用（必读）

| 序号 | 文档 | 链接 | 目的 |
|------|------|------|------|
| 1 | 自己的执行看板 | `goals/agents/{角色名}.md` | 了解自己的职责、协作流程、Done Definition |
| 2 | 多 Agent 分层 Review 协议 | [`docs/multi-agent-review-protocol.md`](https://github.com/NingYuleKK/litch-hub/blob/main/docs/multi-agent-review-protocol.md) | 了解交付标准、合并规则、分工 Review 模式 |
| 3 | Issue 协作规范 | [`docs/issue-collaboration-guide.md`](https://github.com/NingYuleKK/litch-hub/blob/main/docs/issue-collaboration-guide.md) | 了解 CAON comment 格式、Label 体系、Issue 生命周期 |

## 按角色追加

### CC / Claude Code（开发）

| 序号 | 文档 | 链接 | 目的 |
|------|------|------|------|
| 4 | 当前项目的 HANDOVER 文档 | 项目仓库根目录 `HANDOVER_*.md` | 了解技术架构、部署方式、版本历史 |
| 5 | 当前任务的 Issue | litch-hub 对应 Issue | 了解 PRD、护栏、验收口径、所有讨论 |

### Codex（执行语义 Review）

| 序号 | 文档 | 链接 | 目的 |
|------|------|------|------|
| 4 | 当前项目的 HANDOVER 文档 | 项目仓库根目录 `HANDOVER_*.md` | 了解技术架构和数据模型 |
| 5 | 当前任务的 Issue + PR | litch-hub Issue + 项目仓库 PR | 了解需求背景和代码变更 |

### Root / GPT Pro（外部评审）

| 序号 | 文档 | 链接 | 目的 |
|------|------|------|------|
| 4 | 当前任务的 Issue | litch-hub 对应 Issue | 了解 PRD、风险评估、子敬的架构判断 |

### 奉孝（设计 / 前端）

| 序号 | 文档 | 链接 | 目的 |
|------|------|------|------|
| 4 | 当前任务的 Issue | litch-hub 对应 Issue | 了解设计需求和约束 |

## 执行看板快速链接

| 角色 | 执行看板 |
|------|----------|
| 子敬 | [`goals/agents/zijing.md`](https://github.com/NingYuleKK/litch-hub/blob/main/goals/agents/zijing.md) |
| CC | [`goals/agents/cc.md`](https://github.com/NingYuleKK/litch-hub/blob/main/goals/agents/cc.md) |
| Codex | [`goals/agents/codex.md`](https://github.2026/NingYuleKK/litch-hub/blob/main/goals/agents/codex.md) |
| 奉孝 | [`goals/agents/fengxiao.md`](https://github.com/NingYuleKK/litch-hub/blob/main/goals/agents/fengxiao.md) |
| Root | [`goals/agents/root.md`](https://github.com/NingYuleKK/litch-hub/blob/main/goals/agents/root.md) |

## 使用方式

子敬在给任何 agent 开新任务时，briefing 的第一段固定为：

> 开工前请先读以下文档：
> 1. 你的执行看板：{链接}
> 2. 分层 Review 协议：https://github.com/NingYuleKK/litch-hub/blob/main/docs/multi-agent-review-protocol.md
> 3. Issue 协作规范：https://github.com/NingYuleKK/litch-hub/blob/main/docs/issue-collaboration-guide.md
> 4. {当前任务相关文档链接}

---
