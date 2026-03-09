# Issue 协作规范指南

> **文档状态**：v1.0 · 2026-03-03
> **维护者**：agent:zijing（子敬）
> **适用范围**：litch-hub 及所有关联项目的 GitHub Issue 协作流程

---

## 1. Issue 使用规范

### 1.1 两种模板的使用场景

litch-hub 提供两种 Issue 模板，覆盖从轻量讨论到完整任务的全场景：

| 模板 | 适用场景 | Title 前缀 |
|------|----------|------------|
| **💬 Discussion** | 设计讨论、方向探索、概念对齐、轻量小任务 | `[Discussion] 项目名 · 具体话题` |
| **🛠️ Task** | 开发任务、跨项目协作、需要明确验收标准的工作项 | `[Task] 项目名 · 具体任务` |

**Discussion 模板**适用于以下情形：尚未确定方向、需要多方讨论、不涉及代码交付、或任务粒度较小（预计 1-2 小时内可完成讨论）。核心字段为「背景/目的」和「期望结论」。

**Task 模板**适用于以下情形：目标明确、需要 agent 执行、有可验收的交付物、或涉及跨项目协作。核心字段为「期望输出（What）」和「验收标准（Done Definition）」。

### 1.2 Label 使用规则

**每个 Issue 必须至少标注以下四个维度的 Label**，缺少任何一个维度视为不规范：

| 维度 | 必选 Label 数量 | 说明 |
|------|----------------|------|
| **角色** | ≥ 1 | 标注所有参与者（人类 + agents） |
| **状态** | 1 | 反映当前进展，随任务推进更新 |
| **类型** | 1 | 反映任务性质 |
| **优先级** | 1 | 由 Litch 或子敬在开 Issue 时确定 |

#### 角色类 Labels（蓝色系）

| Label | 含义 |
|-------|------|
| `agent:zijing` | 子敬（Manus）— 负责执行、归档、进度跟踪 |
| `agent:fengxiao` | 奉孝 — 战略分析 agent |
| `agent:codex` | Codex — 代码执行 agent |
| `agent:claude` | Claude — 代码/分析 agent |
| `human:litch` | Litch — 人类决策者/CEO |

#### 状态类 Labels（绿黄红色系）

| Label | 含义 | 触发时机 |
|-------|------|----------|
| `status:design` | 设计中 | Issue 创建时默认状态 |
| `status:in-progress` | 进行中 | agent 开始执行时切换 |
| `status:blocked` | 阻塞 | 遇到外部依赖或需要人类决策时 |
| `status:review` | 待审 | 交付物完成，等待 Litch review |
| `status:done` | 完成 | Litch 验收通过，Issue close 前标注 |

#### 类型类 Labels（紫色系）

| Label | 含义 |
|-------|------|
| `type:spec` | 规格文档 — 规范/设计文档类任务 |
| `type:dev` | 开发 — 代码开发类任务 |
| `type:design` | 设计 — UI/UX/系统设计类任务 |
| `type:research` | 调研 — 信息收集/分析类任务 |
| `type:refactor` | 重构 — 代码/结构优化类任务 |

#### 优先级 Labels（橙红色系）

| Label | 含义 | 响应预期 |
|-------|------|----------|
| `priority:p0` | 紧急 | 立即处理，当日完成 |
| `priority:p1` | 重要 | 本周内完成 |
| `priority:p2` | 普通 | 有空处理，无硬截止 |

---

## 2. Comment 格式规范（CAON 四段式）

### 2.1 格式说明

所有 agent 在 Issue 中发表的 comment，**必须遵循 CAON 四段式结构**。这一格式确保每条 comment 都具备可追溯性、可执行性和可交接性。

每条 comment 的开头一行，用粗体标明本条 comment 的类型：

- **交付** — 提交完整的阶段性交付物
- **进度** — 汇报执行进展，无完整交付物
- **阻塞** — 说明阻塞原因，请求人类介入或决策
- **Review** — 对他人交付物的审查意见

### 2.2 CAON 四段式结构

```markdown
**[类型]**

**Context**: 当前基于哪些文件/链接/上下文
（列出本次操作所依赖的具体输入：文件路径、Issue 链接、文档版本等）

**Action**: 做了哪些具体步骤
（按序列出执行的操作，可使用有序列表）

**Output**: 结果
（代码片段、文件链接、要点小结、截图链接等）

**Next**: 建议的下一步（由谁来做）
（明确指出下一步行动和负责人）
```

### 2.3 示例

```markdown
**交付**

**Context**: 基于 [issue-collaboration-guide.md](../docs/issue-collaboration-guide.md) v1.0 和 Litch 在 #12 中的要求。

**Action**:
1. 在 `.github/ISSUE_TEMPLATE/` 下创建 `discussion.yml` 和 `task.yml`
2. 通过 `gh label create` 创建 19 个 Labels（角色/状态/类型/优先级四类）
3. 创建 `docs/issue-collaboration-guide.md` 并 push 到 main

**Output**:
- PR: #13（已合并）
- Labels 截图：[GitHub Labels 页面](https://github.com/NingYuleKK/litch-hub/labels)
- 文档：[issue-collaboration-guide.md](../docs/issue-collaboration-guide.md)

**Next**: `human:litch` review 本文档，确认规范是否符合预期，并决定是否启动 Daily Orchestration Log。
```

---

## 5. 双人分工 Code Review 模式

对于跨 agent 协作的中型及以上 PR，必须执行**子敬 + Codex 双人分工 Code Review**。小 PR 由子敬单独 Review 即可。

### 5.1 分工重点

| 角色 | Review 重点 |
|------|-------------|
| **子敬 (Manus)** | **架构合规性**（PRD 对照、护栏检查、验收清单对照）、**安全检查**（密钥/注入）、**HANDOVER 同步** |
| **Codex** | **代码执行正确性**（逻辑是否真的做到了声称的事）、**类型安全**、**边界 case**、**测试覆盖率**、**性能隐患**（内存/流式/并发）、**依赖安全** |

### 5.2 协作流程

1. CC/Codex 提交 PR 后，触发 Review 流程。
2. 子敬和 Codex 分别独立完成各自侧重点的 Review。
3. 子敬负责收集并整合两份 Review 意见。
4. 子敬将合并成的一份统一修改要求发到 Issue 或 PR 评论中。
5. 开发者根据统一要求进行修改，直至通过双人验收。

---

## 6. 外部评审关卡（跨 Agent 协作必须）

凡是涉及跨子敬和另一个 agent（CC、Codex 等）协作的**中型或大型调整**，子敬写完 Issue/PRD 后，必须强制要求 Litch 找 GPT Pro（Root）评估一次，再开工。

### 判断标准

| 任务规模 | 定义 | 是否需要外部评审 |
|----------|------|------------------|
| **小任务** | 单 agent 独立完成、改动范围小 | 不需要，子敬自行决策 |
| **中型任务** | 跨 agent 协作、涉及架构变更或新模块 | **必须走外部评审** |
| **大型任务** | 新项目、重大重构、跨多个仓库 | **必须走外部评审** |

### 流程

1. 子敬完成 PRD，发到 Issue
2. 子敬通知 Litch："PRD 已就绪，请发给 Root 评审"
3. Litch 将 Issue 链接发给 GPT Pro（Root）
4. Root 评审并反馈建议
5. 子敬根据反馈补充/调整 PRD（在 Issue 下追加 comment）
6. Litch 确认最终版本
7. 开工

> **为什么要这一步？** Root 作为外部评审方，能发现子敬和 CC 可能共同忽略的架构盲点和长期风险。这道关卡的成本很低（一次对话），但能显著降低"能跑但以后很痛"的概率。

---

## 3. Issue 生命周期

### 3.1 开 Issue 时

- 选择正确的模板（Discussion 或 Task）
- 在 body 的「相关链接」字段中，加入相关 litch-hub 文档的链接
- 完整填写所有必填字段
- 标注四个维度的 Labels（角色 + 状态 + 类型 + 优先级）
- **子敬负责**：Issue 的创建、Labels 分配、指派 assignee

### 3.2 进行中

- 执行 agent 按 **CAON 格式**发表进度 comment
- 每完成一个阶段，在 body 的 Done Definition checkbox 中勾选对应项
- 状态 Label 随进展更新：`status:design` → `status:in-progress` → `status:review`
- 遇到阻塞时，立即切换为 `status:blocked`，发表**阻塞** comment，并 @ `human:litch`
- **子敬负责**：进度跟踪、状态 Label 更新

### 3.3 任务完成后

完成后的标准收尾流程：

1. **归档到 hub**：将最终结论/规范写回 litch-hub 对应目录（`projects/`、`team/`、`docs/` 等）
2. **发总结 comment**：在 Issue 中发表**交付** comment，包含归档文件的链接
3. **更新 Labels**：切换为 `status:done`
4. **Close Issue**：由 Litch 或子敬执行 close

> **原则**：Issue 是过程记录，hub 文档是最终结论。任务完成后，结论必须写回 hub，Issue 作为历史存档。

- **子敬负责**：归档、总结 comment、Issue close

### 3.4 生命周期流转图

```
创建 Issue
    │
    ▼
status:design（讨论/设计阶段）
    │  Litch 或子敬确认方案
    ▼
status:in-progress（执行阶段）
    │  agent 按 CAON 格式 comment
    │
    ├─── 遇到阻塞 ──→ status:blocked ──→ Litch 决策 ──→ 返回 in-progress
    │
    ▼
status:review（待审阶段）
    │  Litch review 交付物
    │
    ├─── 需要修改 ──→ 返回 in-progress
    │
    ▼
status:done → 归档到 hub → Close Issue
```

---

## 4. 未来扩展预留

### 4.1 Daily Orchestration Log

当活跃 Issue 数量超过 **10 个**时，启动 Daily Orchestration Log 机制：

- 子敬每日在固定 Issue 中发表一条日志 comment，汇总所有活跃 Issue 的状态
- 格式：`[日期] 活跃 N 个 | P0: X 个 | 阻塞: Y 个 | 待审: Z 个`
- 目的：给 Litch 提供全局视图，避免信息散落

### 4.2 模板扩展空间

当前模板预留了以下扩展点，随实践调整：

- **Discussion 模板**：可增加「讨论时限」字段，避免讨论无限期拖延
- **Task 模板**：可增加「依赖 Issue」字段，显式标注任务间的依赖关系
- **新增模板**：如有必要，可增加 `bug.yml`（缺陷报告）或 `epic.yml`（史诗级任务）

### 4.3 跨仓库协作

当协作扩展到 litch-hub 以外的仓库时：

- 其他仓库的 Issue 在 litch-hub 对应 Issue 的「相关链接」中注明
- 子敬负责跨仓库的进度汇总，统一在 litch-hub 中归档

---

*本文档由 agent:zijing（子敬）创建并维护。如有修订需求，请开 Discussion Issue 讨论后更新。*
