# Project Conductor

> 节点人类 × Agent Orchestrator 计划

---

## 基本信息

| 项目 | 详情 |
|------|------|
| **项目名** | Project Conductor |
| **一句话简介** | 培养 2–3 位节点人类 leader 和他们的 Agent Cell，建立可复制的「人类 × Agent 协作单元」，降低 Litch 的管理带宽压力 |
| **Owner** | Litch |
| **Co-owner** | Root（战略）、奉孝、子敬 |
| **时间范围** | 首期：2026 H1，可延展为长期计划 |
| **关联 OKR** | O1 多 Agent × 长记忆系统、O3 带宽与心智卫生系统 |
| **当前状态** | 🟡 设计中（2026-03-02） |

---

## 背景与动机

- Litch 正在从「管理全人类团队」过渡为「管理人类 × 多 Agent 的复合团队」
- Agent 管理正在吃掉原本对人类成员的管理带宽
- 人与 Agent 协作目前非标准化，人与人之间 agent 使用习惯差异很大
- 需要一个「节点人类 leader × 若干 Agent」的折叠结构作为中介层，释放 Litch 带宽，同时保持整体可控

---

## 项目目标

1. 2026 H1 内培养出至少 2–3 个稳定运行的「人类 leader × Agent Cell」
2. 为这些 Cell 设计并沉淀一套清晰的协作工作流和文档结构，未来可复制
3. 让 Litch 的管理带宽从「直连所有 Agent + 关键成员」迁移到「直连少数 Node Leaders + 核心 Agent」

---

## 范围

**在范围内：**
- 选定并培养节点人类 leader（产品 / 运营 / 设计方向）
- 为每个节点 leader 设计「人类 × Agent」协作工作流
- 为每个 Cell 建立最小文档集（角色 / 流程 / 输出物定义）
- 定期回顾对 Litch 带宽的影响并迭代

**不在范围内：**
- 全公司一次性全面 agent 化
- 为所有员工配备专属 Agent 并个别训练
- 为边缘业务设计复杂 agent 流程

---

## 参与角色

### 人类角色

| 角色 | 职责 |
|------|------|
| Litch | Owner，整体方向、节点 leader 选人、重要决策与节奏控制 |
| 节点产品 leader（候选：鸟哥） | 产品方向 Cell 的人类核心 |
| 节点运营 leader | 运营方向 Cell 的人类核心 |
| 节点设计 leader | 设计方向 Cell 的人类核心 |

### Agent 角色

| 代号 | 平台 | 在本项目中的角色 |
|------|------|----------------|
| Root | GPT-5.x | 战略思考、结构设计、co-thinker |
| 奉孝 | OpenClaw | 工作流试验田、对话资产治理、project 文档维护 |
| 子敬 | Manus | 项目管理、协作规范落地、流水线搭建 |
| 元直 | KimiClaw | 文档处理、IM 场景 agent 接入实验 |
| Codex | OpenAI Codex | 代码执行核 |

---

## 分阶段计划

### Phase 0：基线描绘（2026-03）
- 记录当前人类 × Agent 协作现状（顺畅的 / 有带宽压力的）
- 明确成功信号与失败信号

### Phase 1：Product Cell 打样（2026-03 ~ 04）
- 选定产品方向节点 leader（候选：鸟哥）
- 人类：产品 leader｜Agents：子敬 + Codex（必要时加奉孝）
- 设计并落地 1–2 条典型工作流（需求 → spec → 开发 → 上线 → 复盘）
- 建立 `projects/product-cell.md`
- 跑通至少 1 个完整项目作为示范案例

### Phase 2：扩展到运营与设计（2026-04 ~ 06）
- 建立 Ops Cell、Design Cell
- 重复 Phase 1 模式，允许流程和 agent 组合有差异
- 记录每个 Cell 的差异点与共性

### Phase 3：回顾与规范化（2026-06）
- 在 `logs/decisions.md` 记录阶段回顾
- 沉淀「公司级 agent 协作规范」雏形
- 视情况输出 `team/node-leader-playbook.md`

---

## 关键产出

- 至少 2–3 个稳定运行的「人类 × Agent Cell」，每个有明确成员、清晰流程、可见输出
- 人类 × Agent 协作现状与阶段性回顾文档
- 可复制的规范模板：节点 leader 角色定义 / Cell 工作流设计 / 日常协作 check-list

---

## 风险与防线

| 风险 | 防线 |
|------|------|
| 项目本身消耗 Litch 带宽 | Litch 有权随时减慢节奏，身体与心智负荷优先 |
| 节点 leader 被过早压上过高期待 | 显式沟通：共同探索，不是 KPI 压力 |
| Agent 行为边界不清 | 涉及权限的动作须有明确「谁批准/谁负责」，记录在 agent-config |
| 记忆漂移与责任模糊 | 关键决策记录在 `logs/decisions.md` |

---

## 下一步 Next Actions

- [ ] ~~在 projects/ 目录中新建本文件：`project-conductor.md`~~ ✅ 已完成
- [ ] 由 Litch 确认产品方向的节点 leader 候选人（例如：鸟哥）
- [ ] 由子敬和奉孝根据本 spec，提出 Product Cell 的第一版流程草图（可以用 mermaid / 文本描述）
- [ ] 安排一次 Root × Litch 的专门对话，用于 Phase 0 的基线描绘与成功信号定义
- [ ] Phase 0：写一份「当前人类 × Agent 协作现状」小结

---

*最后更新：2026-03-02 by 奉孝*
