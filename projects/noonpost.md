# Noonpost｜半日来信

> 放置式 AI 探索产品 — 小动物远行，定期寄回来信，LLM 生成见闻/物件/图片。

---

## 基本信息

| 项目 | 详情 |
|------|------|
| **项目名** | Noonpost｜半日来信 |
| **一句话简介** | 放置式 AI 探索产品，小动物远行定期寄回来信，LLM 生成见闻/物件/图片 |
| **GitHub** | [github.com/NingYuleKK/noonpost](https://github.com/NingYuleKK/noonpost)（Private） |
| **线上域名** | 已部署至 manus.space（独立版本） |
| **交接文档** | `HANDOVER_NOONPOST.md`（仓库根目录） |
| **当前版本** | V0.6a（Phase 1+3 已 merge），V0.6b mission-bag-rewire 待开工 |

---

## 技术栈

| 层 | 技术 |
|----|------|
| 前端框架 | Vite + React + TypeScript |
| 样式 | TailwindCSS |
| 游戏引擎 | 自研 game-loop（纯前端，定时器驱动） |
| LLM 调用 | OpenRouter / 火山方舟（双通道），gpt-4.1-mini / gemini-2.5-flash |
| 图片生成 | Seedream（火山方舟） |
| 数据存储 | localStorage（纯前端，无后端） |
| 世界数据 | YAML 节点圣经（手工精修 + Root 审阅） |
| 部署 | Manus Hosted |

---

## 设计风格

**插画 + 像素风混搭** — 信件页面温暖手写感，速写插图用水墨/淡彩风格。整体感觉：收到远方小动物寄来的信和明信片。

---

## 核心功能

**已完成：**

- **V0.3**：核心游戏循环（出发 → 节点停留 → 信件生成 → 到达终点 → farewell）
- **V0.3b**：明信片系统（旅程结束后生成明信片，含旅途精选时刻）
- **V0.4**：mission/风土囊系统（三格收集：种子/器物/风土见闻）+ 物件图鉴
- **V0.5**：T4 prompt 重构设计稿（信件采样规则 + 节点圣经结构化）
- **V0.6a**：速写插图系统（Seedream 生图）+ Phase 1/3 bug 修复

**当前进行中：**

- **V0.6b**（mission-bag-rewire）：风土囊架构重构 — 将风土囊从独立 mission encounter 链路改为从 letter.object 自动归类，Root 评审已通过

**未来规划：**

- 节点圣经扩展（更多西域节点）
- 旅程回放 / 分享
- 多旅行者支持

---

## 世界观

**时代**：西汉建元年间（约前 139-126 年），张骞出使西域的历史背景。

**旅行者**：聆，一只耳廓狐。用鼻子和耳朵认识世界，贪吃，不会说漂亮话。定期给主人寄信。

**路线**：长安 → 河西走廊 → 楼兰 → 大月氏（主线），途经多个西域节点。

**节点圣经**：每个节点有手工精修的世界数据库（10 要素 + Views 结构），经过 Root 两轮审阅定稿。

---

## 关键文档索引

| 文档 | 位置 | 说明 |
|------|------|------|
| 交接文档 | noonpost 仓库 `HANDOVER_NOONPOST.md` | 项目全貌、架构、当前状态 |
| V0.6a 交接包 | noonpost 仓库 `docs/NOONPOST_HANDOVER_PACK_V06A.md` | V0.6a 阶段详细状态 |
| 风土囊重构 spec | **本仓库** [`docs/noonpost-fengtunang-refactor-spec.md`](../docs/noonpost-fengtunang-refactor-spec.md) | V0.6b 架构设计，Root 评审通过 |
| T4 Prompt 重构设计稿 | noonpost 仓库 `docs/NOONPOST_PROMPT_REDESIGN.md` | 信件 prompt 重构方案 |
| 信件采样规则 | noonpost 仓库 `data/letter_sampling_rules.yaml` | 5 槽位采样规则定稿 |
| 节点圣经标准 | noonpost 仓库 `docs/NODE_BIBLE_STANDARD.md` | 节点圣经 10 要素 + Views 结构规范 |

---

## 协作说明

新 Agent 接手时，请先阅读 noonpost 仓库根目录的 `HANDOVER_NOONPOST.md`，再阅读 `docs/NOONPOST_HANDOVER_PACK_V06A.md` 了解当前阶段状态。节点圣经精修使用 `node-bible-refiner` skill。风土囊重构 spec 在本仓库 `docs/` 目录下。
