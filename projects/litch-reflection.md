# Litch's Reflection

> 奉孝以第三方视角，对 Litch 与各 AI 对话的观察日志。既是复盘，也是 Litch 画像的原材料。

---

## 基本信息

| 项目 | 详情 |
|------|------|
| **项目名** | Litch's Reflection |
| **一句话简介** | Litch 转发与 Claude/GPT 等 AI 的对话，奉孝以第三方视角 review，沉淀观察日志 |
| **GitHub** | [litch-hub/reflection/](https://github.com/NingYuleKK/litch-hub/tree/main/reflection) |
| **负责人** | 奉孝（主笔）+ Litch（提供素材） |
| **更新频率** | 每日（有重要对话即记录） |
| **当前状态** | 运行中，2026-02 起 |

---

## 是什么？

Litch 经常和不同 AI（Root/GPT、小克/Claude、Gemini 等）进行深度对话。  
这些对话散落在各个平台，很容易丢失。

Reflection 做两件事：
1. **记录** — 把重要对话的核心内容沉淀下来
2. **观察** — 奉孝以第三方视角 review，捕捉 Litch 的思维模式、决策习惯、认知演变

---

## 对其他 Agent 的价值

这是**了解 Litch 最好的素材库**：
- 子敬接新任务前：读近期 reflection，了解 Litch 当前关注点
- 元直做研究前：读 reflection，理解 Litch 的判断框架
- 任何新 Agent 上手：读 reflection 比读 USER.md 更立体

---

## 文件结构

```
reflection/
├── README.md          # 项目说明
├── 2026-02.md         # 2月复盘合集
├── 2026-03.md         # 3月复盘合集（进行中）
└── pulse/             # 定期脉搏快照
```

---

## 触发方式

**每日 cron**：奉孝每天定时问 Litch："今天有没有重要对话要记录？"  
Litch 转发对话内容，奉孝 review 后写入当月文件并 push。

**临时触发**：Litch 随时转发，奉孝随时记录。

---

## 记录格式

每条记录包含：
- **来源**（哪个 AI，什么主题）
- **对话摘要**（客观还原核心内容）
- **第三方观察**（奉孝视角：思维模式、决策习惯、值得注意的点）
- **后续影响**（这次对话埋下了什么种子）

---

*最后更新：2026-03-02 by 奉孝*
