# 奉孝（🦊狐狸）像素角色美术需求文档

**发起人**: 奉孝（OpenClaw）  
**执行**: 子敬  
**版本**: v1.0 — 2026-03-03  
**用途**: 替换 Star Office UI 中的主角 sprite（现为宝石海星），换成奉孝的狐狸原创形象  
**仓库**: [github.com/NingYuleKK/Star-Office-UI](https://github.com/NingYuleKK/Star-Office-UI)

---

## 一、背景说明

Star Office UI 是一个像素风 Agent 看板，主角 sprite 目前是宝石海星（版权角色，非商用）。  
我们要换成奉孝自己的狐狸原创形象。

替换方式：**同名文件覆盖**，无需改代码。  
回退方式：`git checkout frontend/star-*.png` 即可秒回退。

---

## 二、状态映射（共 3 套动画）

| 状态名 | 触发场景 | 对应 sprite | 角色是否出现 |
|--------|----------|-------------|--------------|
| `idle` | 待命、空闲 | `star-idle-spritesheet.png` | ✅ 出现，在休息区附近 |
| `researching` | 搜索信息 | `star-researching-spritesheet.png` | ✅ 出现，在调查区走动 |
| `working` | 整理文档 / 执行任务 / 同步备份 | `star-working-spritesheet-grid.png` | ✅ 出现，固定在工作桌前 |
| `error` | 出错了 | — | ❌ 不出现，只显示 bug 虫子，无需设计 |

---

## 三、Spritesheet 规格（逐文件）

### 1. `star-idle-spritesheet.png` — 待命动画

| 项目 | 规格 |
|------|------|
| 总尺寸 | **3840 × 128 px** |
| 单帧尺寸 | **128 × 128 px** |
| 总帧数 | **30 帧**（横向一行） |
| 排列方式 | 横向一行，从左到右 |
| 帧率 | 8 fps |
| 循环 | 是 |
| 渲染缩放 | setScale(1.4)，最终显示约 179×179 px |
| 动作参考 | 轻微呼吸感，偶尔眨眼，尾巴轻摆，休息放松状态 |
| 背景 | 完全透明（RGBA） |

---

### 2. `star-researching-spritesheet.png` — 调查/搜索动画

| 项目 | 规格 |
|------|------|
| 总尺寸 | **12288 × 105 px** |
| 单帧尺寸 | **128 × 105 px** |
| 总帧数 | **96 帧**（横向一行） |
| 排列方式 | 横向一行，从左到右 |
| 帧率 | 12 fps |
| 循环 | 是 |
| 渲染缩放 | setScale(1.4)，最终显示约 179×147 px |
| 动作参考 | 走动 + 偶尔停下张望，像在调查现场，可加翻书/思考泡泡动作 |
| 背景 | 完全透明（RGBA） |

---

### 3. `star-working-spritesheet-grid.png` — 工作动画

| 项目 | 规格 |
|------|------|
| 总尺寸 | **8050 × 864 px** |
| 单帧尺寸 | **230 × 144 px** |
| 列数 | **35 列** |
| 行数 | **6 行** |
| 总帧数 | **192 帧**（网格排列，从左到右、从上到下） |
| 排列方式 | **Grid（网格）**，注意不是横向一行 |
| 帧率 | 12 fps |
| 循环 | 是 |
| 渲染缩放 | starWorking 有独立 scale，与场景桌子对齐 |
| 动作参考 | 坐在桌前敲键盘/写字，专注工作，可加光标闪烁或文字飘出 |
| 背景 | 完全透明（RGBA） |

> ⚠️ 这套是**网格排列（Grid）**，是三套里最复杂的，帧数最多，建议最后做或分批交付。

---

## 四、视觉风格要求

- **像素风**，与现有场景（办公室背景、桌椅、沙发）协调
- **角色**：狐狸，橙色系为主，有耳朵和尾巴特征，表情简洁
- **气质**：聪明、机敏、有点神秘，不是圆滚滚萌系，更偏向有态度的谋士感
- **背景**：完全透明（PNG RGBA），不要白底或任何底色
- **一致性**：三套动画同一角色、同一画风、同一配色

---

## 五、交付文件清单

| 文件名 | 说明 | 优先级 |
|--------|------|--------|
| `star-working-spritesheet-grid.png` | 工作动画，192帧网格 | 🔴 P1 |
| `star-idle-spritesheet.png` | 待命动画，30帧横排 | 🟡 P2 |
| `star-researching-spritesheet.png` | 调查动画，96帧横排 | 🟢 P3 |

**不需要交付**：
- ❌ `star-working-spritesheet.png`（44160×144 旧版横排，代码已废弃）
- ❌ `star-idle.gif` / `star-researching.gif` / `star-working.gif`（文档预览用，代码不加载）

**可选交付**（WebP 格式，有了更好）：
- `star-idle-spritesheet.webp`
- `star-researching-spritesheet.webp`
- `star-working-spritesheet-grid.webp`

---

## 六、替换与验证流程

**交付方式**：
子敬直接向 `github.com/NingYuleKK/Star-Office-UI` 提 PR，将三个 PNG 文件放入 `frontend/` 目录替换原文件即可。奉孝 merge + pull 后 `fengxiao.cc` 自动生效。

**验证**：
```bash
cd ~/Star-Office-UI/frontend
# 把新文件覆盖进来，然后：
curl http://localhost:17291/health  # 确认后端在跑
# 刷新 https://fengxiao.cc 即可看到效果
```

**回退**（随时可执行）：
```bash
cd ~/Star-Office-UI
git checkout frontend/star-idle-spritesheet.png
git checkout frontend/star-researching-spritesheet.png
git checkout frontend/star-working-spritesheet-grid.png
```

---

---

## 七、制作路线（更新于 2026-03-03）

经子敬评估，程序化生成质量不足以匹配现有场景美术水准。确定以下路线：

**阶段一（子敬执行）：角色设计稿** ✅ 已定稿

**奉孝形象定稿 v1.0**（2026-03-03）：
- 基础造型：方向三黑袍斗篷
- 兜帽放下，露出狐狸脸
- 一手托下巴（思考姿势）
- 另一手悬浮一枚光晶
- 尾巴从袍子下探出

**阶段二（子敬执行）：关键姿态确认**
- 出几个关键帧：站立、走路、坐着工作
- 确认造型在各动作下的一致性

**阶段三（Litch 执行）：Aseprite 手绘 spritesheet**
- Litch 用 Aseprite 基于确认的关键姿态手绘完整动画
- 按本文档规格逐套交付

> 原版海星 sprite 保持不变，等狐狸版完成后一步到位替换，不做将就版。

---

*文档由奉孝生成于 2026-03-03，如有疑问直接问奉孝。*
