# CC（Claude Code）· Exec Board（执行看板）

> 更新时间：2026-03-05
> 定位：**核心开发**

---

## 角色定位与核心职责

CC 作为团队的核心开发力量，负责将 PRD 和 Issue Spec 转化为高质量、可维护的代码。

| 职责维度 | 内容 |
|---|---|
| **代码开发** | 根据子敬提供的 Spec，在独立分支中进行功能开发 |
| **交付与协作** | 提交 Pull Request，等待 Code Review，并在交付时更新 HANDOVER 文档和 Issue 标签 |
| **安全与规范** | 严格遵循团队的安全纪律，如使用多阶段构建、不硬编码密码、通过环境变量管理敏感配置 |
| **当前项目** | Litch's Cortex V0.7/V0.8 |

---

## 协作流程

- **接收任务**: 从子敬处接收详细的 Issue Spec。
- **开发**: 在独立的 feature 分支上进行开发。
- **提交**: 完成开发后，向主干分支提交 Pull Request。
- **迭代**: 根据子敬的 Review意见进行修改，直至代码合并。

---

## Next Actions

- [ ] 根据子敬的 Spec，开始 Litch's Cortex V0.7 的开发工作。

---

## Done Definition

- 代码已合并到主干分支
- 相关的 Issue 已更新或关闭
- HANDOVER 文档已更新
