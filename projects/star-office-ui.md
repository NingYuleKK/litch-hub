# Star Office UI

> 像素风多 Agent 可视化办公室看板 — 实时看到你的 AI 团队在做什么。

---

## 基本信息

| 项目 | 详情 |
|------|------|
| **项目名** | Star Office UI |
| **一句话简介** | 像素风多 Agent 可视化办公室看板，AI 助手根据状态自动走到不同区域 |
| **GitHub** | [github.com/NingYuleKK/Star-Office-UI](https://github.com/NingYuleKK/Star-Office-UI)（Public） |
| **线上域名** | [fengxiao.cc](https://fengxiao.cc) |
| **本地路径** | `/Users/litch/Star-Office-UI` |
| **交接文档** | `HANDOVER.md`（仓库根目录） |
| **当前版本** | v1.0（运行中） |

---

## 技术栈

| 层 | 技术 |
|----|------|
| 前端 | Phaser.js 像素风静态页面 |
| 后端 | Python Flask，端口 17291 |
| 公网暴露 | Cloudflare Named Tunnel `star-office` |
| 域名 | fengxiao.cc（Cloudflare 管理，自动 HTTPS） |

---

## 核心功能

- AI 助手根据工作状态自动走到不同区域（工作区/休息区/Bug 区/写作区）
- 展示「昨日小记」，从 `~/.openclaw/workspace/memory/YYYY-MM-DD.md` 自动读取
- 支持多个 Agent 以访客身份加入，各自推送状态
- 适配手机端，通过 Cloudflare Tunnel 固定域名公网访问

---

## Agent 接入状态

| Agent | 状态 |
|-------|------|
| 奉孝（OpenClaw） | ✅ 接入，主看板 |
| 子敬（Manus） | 🔜 待接入 |
| 元直（KimiClaw） | 🔜 待接入 |

---

## 启动方式

```bash
cd /Users/litch/Star-Office-UI

# 启动后端
cd backend && python3 app.py &

# 启动 Named Tunnel
cd .. && ./start-tunnel.sh &
```

---

## 协作说明

新 Agent 接手时，请先阅读仓库根目录的 `HANDOVER.md`。  
Agent 推送状态 API：`POST https://fengxiao.cc/agent-push`，详见 README。
