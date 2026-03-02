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

## Root（root-backup / GPT）

| 项目 | 详情 |
|------|------|
| **平台** | OpenClaw（root-backup agent） |
| **Agent ID** | `root-backup` |
| **模型** | `openrouter/openai/gpt-5.1` |
| **Telegram Bot** | Root 专属 bot（独立账户） |
| **Telegram 绑定** | `channels.telegram.accounts.root` → `root-backup` agent |
| **操作权限** | ❌ 无（纯对话，不执行工具） |
| **职能** | 战略思考、产品讨论、外脑 coach |
| **配置文件** | `~/.openclaw/openclaw.json` → `agents.list[id=root-backup]` |

---

## 双 Bot Telegram 结构

```
Telegram
├── accounts.main  → 奉孝 bot → main agent（sonnet-4.6）
└── accounts.root  → Root bot → root-backup agent（gpt-5.1）
```

两个 bot 独立运行，Litch 可以分别和奉孝、Root 对话，互不干扰。

---

## 其他 Agent（待接入）

| Agent | 平台 | 状态 |
|-------|------|------|
| 子敬（Manus） | Manus | 独立运行，通过 litch-hub 共享信息 |
| 元直（KimiClaw） | 飞书 | 待配置 |
| Codex | OpenAI Codex | 按需调用 |

---

*最后更新：2026-03-02 by 奉孝*
