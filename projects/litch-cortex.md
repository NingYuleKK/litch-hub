# Litch's Cortex

> 对话资产治理工具 — 将你与 AI 的每一次对话，转化为可检索、可迁移的认知资产。

---

## 基本信息

| 项目 | 详情 |
|------|------|
| **项目名** | Litch's Cortex |
| **一句话简介** | 对话资产治理工具，PDF 解析 + LLM 话题提取 + 摘要生成，赛博认知深色主题 |
| **GitHub** | [github.com/NingYuleKK/litch-cortex](https://github.com/NingYuleKK/litch-cortex)（Private） |
| **线上域名** | [litchcortex-b5ulm8lp.manus.space](https://litchcortex-b5ulm8lp.manus.space) |
| **交接文档** | `HANDOVER_CORTEX.md`（仓库根目录） |
| **当前版本** | v0.x（Step 1 开发中） |

---

## 技术栈

| 层 | 技术 |
|----|------|
| 前端框架 | Vite + React + TypeScript |
| 样式 | TailwindCSS |
| 可视化 | D3.js（力导向图 / 话题星图） |
| API 层 | Node.js + tRPC |
| PDF 解析 | pdf-parse（npm） |
| LLM 调用 | OpenAI API（gpt-4.1-mini） |
| 数据库 | SQLite |
| ORM | Drizzle ORM |
| 部署 | Manus Hosted |

---

## 设计风格

**赛博认知风格** — 深蓝/暗紫底色 + 荧光节点。星图背景有微弱网格线，像神经网络。节点发光效果，hover 时扩大并高亮关联线。整体感觉：你在观察自己的认知网络。

---

## 核心功能

**Step 1（当前阶段）：**

- PDF 上传与解析（拖拽上传，显示解析进度）
- 文本分段（chunk）与存储
- LLM 批量话题提取与聚类（gpt-4.1-mini，成本优化）
- 话题星图可视化（D3.js 力导向图，节点大小 = 关联 chunk 数）
- 话题详情页（原文片段 + 按需生成 LLM 总结）
- 认知资产导出（Markdown，总结 + 关键原文片段）

**未来规划：**

- 多来源数据接入（Telegram、Slack、Discord）
- 隐私保护与 PII 清洗（参考 DataClaw 方案）
- 全文检索引擎
- 多用户协作（可选）

---

## 架构文档

- 架构设计：[`docs/dialogue-asset-architecture.md`](https://github.com/NingYuleKK/litch-cortex/blob/main/docs/dialogue-asset-architecture.md)
- DataClaw 调研：[`docs/dataclaw-analysis.md`](https://github.com/NingYuleKK/litch-cortex/blob/main/docs/dataclaw-analysis.md)（同步见本仓库 [`research/dataclaw-analysis.md`](../research/dataclaw-analysis.md)）

---

## 协作说明

新 Agent 接手时，请先阅读仓库根目录的 `HANDOVER_CORTEX.md`，再阅读 `docs/` 目录下的架构设计文档。当前处于 Step 1 阶段，优先完成 5 个核心 Issue（PDF 解析 → 话题提取 → 星图 → 详情 → 导出）。
