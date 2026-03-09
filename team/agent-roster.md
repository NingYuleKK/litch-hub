# Agent 团队花名册 (Agent Roster)

> 更新时间：2026-03-09
> 本文档记录了 Litch 团队中所有活跃的 AI Agent 及其核心职能。

---

## 核心团队成员

### 1. Root (GPT Pro)
- **定位**: 外部评审 & 架构盲点扫描
- **平台**: GPT Pro
- **核心职能**:
  - 战略思考、产品讨论、外脑 coach
  - 对跨 agent 协作的中型或大型任务进行架构评审
  - 补充技术护栏，对未来版本的潜在风险进行预判和扫描

### 2. 小克 (Claude)
- **定位**: 思考辅助
- **平台**: Claude
- **核心职能**:
  - 思考辅助、对比分析

### 3. 奉孝 (OpenClaw)
- **定位**: 个人助手 & 资产治理
- **平台**: OpenClaw (sonnet-4.6)
- **核心职能**:
  - 个人助手、对话资产治理
  - 代码 review（辅助）

### 4. 子敬 (Manus)
- **定位**: 中枢管理、架构设计与执行验收
- **平台**: Manus
- **核心职能**:
  - 项目管理、协调开发、架构设计、验收部署
  - 编写 PRD 和 Issue Spec，分配任务
  - **双人 Code Review 统筹**: 负责架构合规性（PRD 对照、护栏检查、验收清单对照）、安全检查（密钥/注入）、HANDOVER 同步，并整合 Codex 的 Review 意见。

### 5. 元直 (KimiClaw / 飞书)
- **定位**: 执行与研究
- **平台**: KimiClaw / 飞书
- **核心职能**:
  - 执行、研究、长文档处理

### 6. Codex (OpenAI Codex)
- **定位**: 核心代码编写与深度 Review
- **平台**: OpenAI Codex
- **核心职能**:
  - 代码编写与功能实现
  - **双人 Code Review 参与**: 负责代码执行正确性（逻辑是否真的做到了声称的事）、类型安全、边界 case、测试覆盖率、性能隐患（内存/流式/并发）、依赖安全。

---

## 协作说明

详细的协作模式和流程，请参考 [`team/collaboration-guide.md`](./collaboration-guide.md) 和 [`docs/issue-collaboration-guide.md`](../docs/issue-collaboration-guide.md)。
