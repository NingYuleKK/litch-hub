# Agent 技术配置文档

> 各 Agent 的运行环境、模型、接入方式。供技术维护和新 Agent 接手时参考。

---

## 奉孝（OpenClaw / main）

| 项目 | 详情 |
|------|------|
| **平台** | OpenClaw |
| **Agent ID** | `main` |
| **模型** | `openrouter/anthropic/claude-sonnet-4.6`（primary） |
| **Fallback** | gpt-5.1 → deepseek-v3.2 → glm-4-7 |
| **Telegram Bot** | 奉孝专属 bot（fengxiao bot） |
| **操作权限** | ✅ 完整（读文件、执行命令、控制浏览器等） |
| **工作目录** | `/Users/litch/.openclaw/workspace` |
| **记忆文件** | `MEMORY.md`（长期）+ `memory/YYYY-MM-DD.md`（日记） |
| **配置文件** | `~/.openclaw/openclaw.json` → `agents.list[id=main]` |

---

## Root

| 项目 | 详情 |
|------|------|
| **平台** | — |
| **核心职能** | 战略思考、产品讨论、外脑 coach |
| **说明** | Root 的 prompts 分散在多个平台，暂不在仓库中记录。 |

---

## 其他 Agent（待接入）

| Agent | 平台 | 状态 |
|-------|------|------|
| 子敬（Manus） | Manus | 独立运行，通过 litch-hub 共享信息 |
| 元直（KimiClaw） | 飞书 | 待配置 |
| Codex | OpenAI Codex | 按需调用 |

---

*最后更新：2026-03-02 by 奉孝*
