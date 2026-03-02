# Decisions Log（决策账本）

> 防记忆漂移。每次重要决策都记在这里，agent 和 Litch 都不用靠「印象」。

---

## 2026-03-02 · 长记忆系统架构确定

**结论**：采用三层结构（North Star OKR / Now 周执行 / Agent Exec Board）+ KR映射表，落地在 litch-hub/goals/

**背景**：过去 agent 之间目标脱节，session 重启后上下文丢失，导致执行和愿景分离。

**取舍**：放弃 GitHub Actions 自动开 Issue（维护成本高），改用奉孝 cron 敲铃提醒更新。

**影响范围**：奉孝、子敬、元直、Litch 全部涉及。

**证据**：[goals/](./goals/)

---

## 2026-03-02 · 项目文档规则确立

**结论**：每个项目必须同时有 README.md 和 HANDOVER.md，写完代码必须 push，新增项目必须更新 litch-hub README。

**背景**：Star Office UI session 重启后上下文全丢，昨天的工作今天重头来过。

**取舍**：双向校验机制（Litch 收工 check + 奉孝主动更新），不依赖单方记忆。

**影响范围**：所有项目，所有 agent。

**证据**：[AGENTS.md 项目文档规则区块](../workspace/AGENTS.md)

---

## 2026-03-02 · fengxiao.cc Named Tunnel 上线

**结论**：用 Cloudflare Named Tunnel + launchd 托管，固定域名 fengxiao.cc，开机自启。

**背景**：临时 Tunnel 每次重启地址变化，且进程依赖 session 存活。

**取舍**：放弃临时 Tunnel 方案，改用 Named Tunnel + launchd，一次配好永久生效。

**影响范围**：Star Office UI 项目。

**证据**：[Star-Office-UI/HANDOVER.md](https://github.com/NingYuleKK/Star-Office-UI)
