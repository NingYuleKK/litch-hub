# Litch's Agent Team Shared Knowledge Base

**这是 Litch 的 Agent 团队共享知识库。** 所有 Agent（奉孝、元直、子敬、Codex）均可读取本仓库，以获取项目背景、IP 设定、调研文档和协作规范。

---

## 项目概览

Litch 正在构建一个由多个 AI Agent 协作驱动的个人数字产品矩阵。本仓库作为团队的"公共记忆"，承担以下职能：

- **项目快速上下文**：每个项目一页纸 sketch，新 Agent 接手时可快速定位
- **IP 设定存档**：统一管理虚拟角色设定，确保跨项目一致性
- **调研文档沉淀**：将有价值的技术调研和分析报告归档，避免重复劳动
- **协作规范说明**：明确 Agent 团队的分工模式和工作流程

---

## 目录结构

| 目录 | 说明 |
|------|------|
| [`projects/`](./projects/) | 各项目快速 sketch，每个文件为一页纸概览 |
| [`goals/`](./goals/) | 长记忆系统：OKR / Now 周执行 / Agent Exec Board / KR映射表 |
| [`profile/`](./profile/) | Litch 决策画像，Agent 接手任务前建议阅读 |
| [`logs/`](./logs/) | 决策账本，防记忆漂移 |
| [`ip/`](./ip/) | IP 角色设定文档，包含外形、性格、世界观等完整设定 |
| [`research/`](./research/) | 技术调研与分析报告，来源于 Agent 团队的深度研究 |
| [`team/`](./team/) | Agent 团队花名册、技术配置与协作模式说明 |
| [`reflection/`](./reflection/) | 奉孝对 Litch 与各 AI 对话的第三方观察日志 |

---

## 项目列表

| 项目 | 简介 | 域名/地址 | 状态 |
|------|------|-----------|------|
| [Star Office UI](./projects/star-office-ui.md) | 像素风多 Agent 可视化办公室看板 | [fengxiao.cc](https://fengxiao.cc) | ✅ 运行中 |
| [Project Conductor](./projects/project-conductor.md) | 节点人类 × Agent Cell 协作单元，降低 Litch 管理带宽 | — | 🟡 设计中 |
| [Litch's Reflection](./projects/litch-reflection.md) | 奉孝对 Litch 对话的第三方观察日志 | litch-hub/reflection/ | ✅ 运行中 |
| [Litch's Nexus](./projects/litch-nexus.md) | 多 AI 回答对比收集器，赛博简洁风格 | litchnexus-dgns85r2.manus.space | Private |
| [Litch's Cortex](./projects/litch-cortex.md) | 对话资产治理工具，PDF 解析 + LLM 话题提取 | — | Private |
| [Litch Notes 闲步金瓶梅](./projects/litch-notes.md) | 金瓶梅研究笔记站，深夜书房暗色风格 | — | Public |
| [Litch's Check](./projects/litch-check.md) | 个人目标打卡工具，司马黑吉祥物监督 | — | Private |

---

## Agent 团队

| 轴 | 代号 | 平台 | 核心职能 |
|----|------|------|---------|
| 思考轴 | Root | GPT-5.1 / OpenClaw | 战略思考、产品讨论、外脑 coach |
| 思考轴 | 小克 | Claude | 思考辅助、对比分析 |
| 工作轴 | 奉孝 | OpenClaw (sonnet-4.6) | 个人助手、对话资产治理、代码 review |
| 工作轴 | 子敬 | Manus | 项目管理、协调开发、架构设计、验收部署 |
| 工作轴 | 元直 | KimiClaw / 飞书 | 执行、研究、长文档处理 |
| 工作轴 | Codex | OpenAI Codex | 代码编写 |

详见 [`team/agent-roster.md`](./team/agent-roster.md) · [`team/agent-config.md`](./team/agent-config.md) · [`team/collaboration-guide.md`](./team/collaboration-guide.md)

---

*本仓库由奉孝 + 子敬共同维护，所有 Agent 均可提交更新。最后更新：2026-03-02*
