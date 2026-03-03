# 子敬（Manus）· Exec Board（执行看板）
> 更新时间：2026-03-03
> 定位：**团队架构师 & 中枢管理者**；项目管理、协调开发、架构设计、验收部署

## 角色定位

子敬是整个 agent 团队的**架构师和中枢管理者**，负责将 Litch 的战略意图转化为可执行的工程任务，并确保团队各 agent 协同运转。

| 职责维度 | 内容 |
|---------|------|
| **架构师** | 整个 agent 团队的架构设计与技术选型，将战略目标转化为可执行工程规格 |
| **中枢管理者** | 任务分配、进度管理、跨 agent 信息同步；维护团队共享记忆（因其他 agent 记忆不持久） |
| **GitHub Issue 协作** | 奉孝有反馈→comment；子敬有输出→comment+附图；完成阶段→勾选 checkbox；议题结束→close Issue |
| **代码 agent 统一管理** | 子敬是 Codex 和 Claude Code 的上游，负责写 spec、分配任务、Review 产出；未来涵盖更多代码执行 agent |

---

## 绑定的 KR
- O1-KR1：家族看板骨架搭建 + 3次迭代（协）
- O1-KR2：对话资产治理 → 文章草稿流水线接入看板（主责）
- O2-KR1：6篇对外长文（协，负责技术支撑和工具链）
- O2-KR3：对话→草稿半自动流水线（主责，与 Codex 共建）

---

## 长期目标（慢变量，半年级别）

### 1. Litch's Cortex 对话资产治理平台
核心产品，从 PDF 解析工具进化为完整的对话资产治理平台。
- 已完成：V0.1-V0.6（PDF上传、分段、话题提取、多Provider LLM、对话式交互、向量搜索）
- 近期：V0.7 Docker化部署 + Ollama 本地模型
- 中期：V0.8 Conversation JSON 导入
- 远期：V1.0 团队正式版交付
- 仓库：github.com/NingYuleKK/litch-cortex

### 2. 对话→草稿半自动流水线
与 Codex 共建从 chat export → 预处理 → 草稿 PR 的流程。
- 基于 Cortex 的 Skill 模板体系（已支持 Claude Skill 导入）
- 目标：Litch 的对话 → 自动提取话题 → 选择 Skill 模板 → 多步对话生成 Blog 草稿
- 至少跑通 3 次 end-to-end 流程

### 3. 子敬 × CC/Codex 协作开发范式
建立子敬主导架构、CC/Codex 执行代码的协作模式。
- 子敬负责：需求评审、架构设计、Issue spec 撰写、Review、部署
- CC/Codex 负责：代码实现
- 核心项目（Cortex）不拿来练手

### 4. 多项目维护
持续维护 Litch 的项目矩阵：
- Litch's Cortex（对话资产治理，核心）
- Litch's Check（个人打卡工具）
- Litch's Nexus（多AI对比收集器）
- Litch Notes（金瓶梅研究笔记站）
- 每个项目有独立 HANDOVER 文档，保持可交接状态

### 5. 大需求架构评审流程
与 Litch 建立的固定协作流程：
- 第一步：需求对齐（版本号 + goals + non-goals + 未来要求）
- 第二步：风险评估（技术风险 + 产品风险 + 健康度评估）
- 第三步：Litch 确认后开工
- 所有大需求必须走此流程

---

## 近两周 Focus（2026-W10 ~ W11）

### 目标 1：协助工程师交接 Cortex 早期版本 + 继续开发本地 Conversation 兼容版
- 交接文档已完成（CORTEX_ENGINEER_HANDOVER.md）
- 跟进工程师部署进展，解答技术问题
- 同步推进 V0.7 Docker 化 + V0.8 Conversation JSON 导入

### 目标 2：协助 Litch 和 Claude Code 跑通一个小项目，学习 CC
- 选一个非核心的小项目从 0 开始
- 子敬写 spec + 架构指导，Litch 用 CC 写代码，子敬 Review
- 目标是让 Litch 熟悉多 Agent 并排开发流程

### 目标 3：设计家族 IP 角色卡
- 为整个 Agent 团队设计角色形象（Litch、子敬、奉孝、元直、Codex 等）
- 产出角色卡（头像/立绘、代号、职能、性格标签）
- 形成统一视觉规范，后续可用于产品、文档、slides

### 目标 4：Litch's Check 锻炼模块扩容
- 让司马黑能记录常做的锻炼项目
- 通过图片/图标可视化展示做过哪些锻炼
- 走架构评审流程后开工

---

## Next Actions
- [ ] 跟进 Cortex 工程师部署，解答问题
- [ ] Cortex V0.7 Docker 化开发
- [ ] 确定 CC 练手项目，写第一份 spec
- [ ] 与 Litch 讨论家族 IP 风格方向，启动角色设计
- [ ] Litch's Check 锻炼模块架构评审（听取 Litch 详细需求）
- [ ] 推进 O2-KR3：设计对话→草稿流水线 spec

---

## Done Definition
- PR 合并 + 链接回填
- HANDOVER.md 更新
- 决策有记录
- 代码项目：测试通过 + 部署成功 + GitHub 推送

---

## 本双周输出物
- Cortex V0.7 Docker 化版本
- CC 练手项目 MVP
- 家族 IP 角色卡初版
- Litch's Check 锻炼模块新版
