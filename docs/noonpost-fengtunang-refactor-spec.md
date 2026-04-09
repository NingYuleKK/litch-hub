# Noonpost · 风土囊架构重构 Spec

> **版本**：V1.1（Root 评审修订版）  
> **状态**：Root 评审通过，待开工  
> **维护人**：子敬  
> **版本号**：V0.6b mission-bag-rewire  
> **前置**：V0.6a Phase 1+3 已 merge，线上版本独立部署不受影响

---

## 〇、Root 评审结论与修订记录

> **Root 最终裁决：通过。**

Root 评审通过了方向和架构，同时给出 **3 条硬边界** 和 **2 条软建议**，已全部落实到本文档中。

### 硬边界修订

| # | Root 要求 | 落实位置 | 修订内容 |
|---|----------|----------|----------|
| H1 | 风土囊只吃通过 provenance 校验的 object，不用 name fallback 顶替 | §3.2.1 填充流程 + §3.2.3 Provenance 硬门槛 | 删除 `anchorText ?? name` fallback；新增 provenance 校验前置条件；无 anchorText 的物件只进图鉴不进囊 |
| H2 | folklore 在呈现上必须和真正器物区分，不要假装成实物 | §3.5 UI 层变更 + §3.5.4 folklore 呈现规范 | folklore 使用卷轴/札记视觉语言，不使用物件卡片；CollectionPage 和 MissionProgress 分层显影 |
| H3 | "先到先得"加最小质量护栏，避免太泛的早期物件抢占 slot | §3.2.4 质量护栏 | 新增 objectPool 命中优先 + mission 节点加权规则；非 objectPool 物件在旅程前 1/3 不允许首次占位 |

### 软建议落实

| # | Root 建议 | 落实位置 |
|---|----------|----------|
| S1 | 独立成小版本，不要混进别的版本 | 版本号改为 V0.6b mission-bag-rewire |
| S2 | CollectionPage 加一句解释文案 | §3.5.1 CollectionPage |

---

## 一、问题诊断

### 1.1 核心问题：两套断开的系统

当前 Noonpost 中"物件图鉴"和"风土囊"是两套完全独立的系统，数据不互通：

| 系统 | 数据源 | 读取方式 | 当前状态 |
|------|--------|----------|----------|
| **物件图鉴** (`CollectionPage.tsx`) | `letter.object`（每封信可能附带的 `LetterObject`） | 遍历 `session.letters.filter(l => l.object)` | ✅ 正常工作，已收集到羊骨、石片、斗篷残片等 |
| **风土囊** (`MissionProgress.tsx`) | `missionState.slots`（mission encounter 触发 → pendingFill → provenance 匹配 → fillSlot） | 读取 `session.missionState.slots` | ❌ 三格全空 |

**物件图鉴的数据流**（正常工作）：

```
LLM 生成信件 → parseLLMResponse 解析 object 字段
→ validateAnchorText 验证锚文本 → letter.object 写入
→ CollectionPage 遍历 letters 展示
```

**风土囊的数据流**（断裂）：

```
encounter 引擎选中 mission encounter（missionRelated: true）
→ 创建 PendingSlotFill（slotId + promptHook）
→ 信件生成后，findAnchorInContent 在信件正文中搜索 promptHook 的子串
→ 如果找到（HIT）→ fillSlot 填充 missionState.slots
→ 如果没找到（MISS）→ pendingFill 被永久消费，slot 永远空
```

### 1.2 P1 Bug：pendingFill 在 MISS 时被永久消费

**位置**：`engine/backlog.ts` line 372-382

```typescript
// Remove this pending fill regardless (consumed or graceful no-fill)
missionState = {
  ...missionState,
  pendingFills: missionState.pendingFills?.filter(p => p !== pending),
};
```

无论 provenance 匹配成功还是失败，`pendingFill` 都会被移除。这意味着：

- mission encounter 触发了（概率已经不高）
- LLM 写了信但没有精确命中 promptHook 的 3-char 子串
- 这次机会就永久丢失了，该 slot 再也没有机会被填充

### 1.3 风土囊为什么几乎总是空的：概率分析

**旅程总拍数**：主线 10-22 拍（平均 ~16 拍）

**每个 slot 的填充概率链**：

| 步骤 | 概率 | 说明 |
|------|------|------|
| ① encounter 引擎触发 | ~60% per beat | 基础触发率 |
| ② 选中 mission encounter | ~23% | weight=3 在 eligible pool 中的占比 |
| ③ slot 对应节点有拍数 | 1-3 拍 | 每个 mission encounter 只在 1 个节点可触发 |
| ④ LLM 正文命中 promptHook 子串 | ~40-60% | findAnchorInContent 用 3-char 滑窗，但 LLM 自由写作不一定包含 hook 关键词 |
| ⑤ pendingFill 未被 MISS 消费 | 一次性 | MISS 即永久消费 |

**单个 slot 在整个旅程中被填充的概率**：

每个 slot 有 3 个 mission encounter 分布在 3 个节点，每个节点平均 2 拍。

- P(至少触发一次 mission encounter) ≈ 1 - (1 - 0.6 × 0.23)^6 ≈ 60%
- P(触发后 provenance HIT) ≈ 40-60%
- P(单个 slot 最终填充) ≈ 60% × 50% ≈ **30%**

**三格全满的概率** ≈ 30%³ ≈ **2.7%**

> 这解释了为什么风土囊几乎总是空的：即使 mission encounter 设计得很好，整个概率链太长、每一步都在衰减，最终填充率极低。

### 1.4 根因总结

这不是 bug，是 **PRD 缺口**（D 类）：

1. V0.4 设计时，物件图鉴和风土囊被设计为两套独立系统，没有定义它们之间的关联规则
2. 风土囊依赖一条极长的概率链（encounter 触发 → mission encounter 选中 → LLM 写出 hook 关键词 → provenance 匹配），每一步都在衰减
3. `pendingFill` 的"一次性消费"设计让本就脆弱的链路雪上加霜

---

## 二、产品语义裁决

### 2.1 Litch 的方向确认

> "user 层面最顺的，肯定是随信寄回来的物品里有种子、器物和见闻。"
> "似乎这意味着信件甚至是节点圣经里可能要覆盖类似的触发点？"

### 2.2 方案选择：方案 A — 风土囊是物件图鉴的"精选"

**核心语义**：

- **物件图鉴**：收集所有 `letter.object`，是"路上带回来的所有东西"
- **风土囊**：从物件图鉴中自动归类到三格（种子/器物/风土见闻），是"带回来的东西里最有代表性的三样"
- **数据源统一**：风土囊不再有独立的 slot 填充链路，而是直接从 `letter.object` 归类

**"从信里长出来"原则**：

信件正文提到某物 → `letter.object` → 同时进物件图鉴 + 归类到风土囊对应格子

这样风土囊就不再是一个独立的 mission 系统在等 encounter 触发，而是信件写作过程中自然长出来的。

### 2.3 废弃的旧机制

以下机制将被废弃或大幅简化：

| 旧机制 | 处理方式 |
|--------|----------|
| `encounters.yaml` 中 9 个 mission encounter | **保留但降级**：去掉 `missionRelated` 和 `grantSlot` 标记，变成普通 encounter，promptHook 仍然注入信件 prompt，但不再直接触发 slot 填充 |
| `PendingSlotFill` 机制 | **废弃**：不再需要 pendingFill → provenance 匹配的链路 |
| `findAnchorInContent` / `extractContextAroundAnchor` | **废弃**：不再需要在信件正文中搜索 promptHook 子串 |
| `backlog.ts` line 340-382 的 pendingFill 消费逻辑 | **替换**：改为物件归类逻辑 |

---

## 三、架构设计

### 3.1 物件归类机制

#### 3.1.1 归类规则

每个 `letter.object` 在生成时，由 LLM 同时标注其 `slotType`：

```typescript
type SlotType = 'seed' | 'artifact' | 'folklore';
```

归类规则：

| slotType | 含义 | 典型物件 |
|----------|------|----------|
| `seed` | 能发芽的东西，代表"远方里能继续生长的部分" | 葡萄籽、沙枣核、不知名的种子 |
| `artifact` | 路上用过的器物，代表"路途本身的痕迹" | 水葫芦、火石、青铜小杯、陶片 |
| `folklore` | 气味、歌调、食物、习俗、传闻——不是实物，而是可带回讲的风土片段 | 烤饼的做法、一段旋律、发酵马奶的味道 |

#### 3.1.2 LLM 标注方式

在 `OBJECT_ATTACHMENT_PROMPT` 和 `OBJECT_INSTRUCTION` 中增加 `slotType` 字段要求：

```
- "slotType": 从以下三个中选一个最贴切的：
  - "seed"：能种的、能发芽的、有生命力的东西（种子、果核、活的植物枝条）
  - "artifact"：路上用过的、摸过的、带着使用痕迹的器物（工具、容器、饰品、碎片）
  - "folklore"：不是实物，而是一段见闻、一种做法、一个声音、一种味道的记忆
```

#### 3.1.3 节点圣经物件采样池

在节点圣经中新增 `objectPool` 字段，为 LLM 提供"这个节点最可能产出什么类型物件"的引导：

```yaml
hexi_corridor:
  # ... 现有字段 ...
  objectPool:
    seed:
      - name: 沙枣核
        hint: 沙枣表面银白粉末，入口干涩，嚼后微甜。核很硬，也许能种
      - name: 骆驼刺种子
        hint: 骆驼刺的荚果裂开后掉出来的小粒，干燥坚硬
    artifact:
      - name: 风蚀石片
        hint: 被风削成薄片的石头，边缘锋利，可以切东西
      - name: 旧皮水囊
        hint: 别人丢下的水囊，摇了摇还有水声，囊口系着一截旧皮绳
    folklore:
      - name: 酸马奶的味道
        hint: 匈奴人把马奶发酵了喝，酸得能让人皱一天的脸
      - name: 匈奴岩画
        hint: 石壁上刻着奔跑的马和弯弓的人，线条粗犷
```

**注意**：这不是硬编码"必须出这个"，而是给 LLM 一个采样池。LLM 可以从池中选，也可以根据信件内容自然产生新的物件。`slotType` 的标注才是归类的依据。

#### 3.1.4 Prompt 注入方式

当 `shouldAttachObject` 返回 true 时，在 prompt 中注入当前节点的物件采样池：

```
【附带物件】
这封信里你提到了某件具体的东西，你决定把它寄给主人。

这个地方可能带回的东西：
- 种子类：{seed pool hints}
- 器物类：{artifact pool hints}
- 见闻类：{folklore pool hints}

你可以从上面选，也可以写信时自然带出别的东西。
在 JSON 中额外包含 "object" 字段，含：
- "name": 物件名称
- "description": 物件描述，30-80字
- "slotType": "seed" / "artifact" / "folklore"
- "iconType": ...（保持现有选项）
- "anchorText": ...（保持现有规则——必须是信件正文中出现的原文片段）
```

### 3.2 风土囊填充逻辑

#### 3.2.1 新的填充流程

替换 `backlog.ts` 中原有的 pendingFill 消费逻辑：

```typescript
// 新逻辑：信件生成后，如果有 object 且有 slotType，尝试归类到风土囊
if (missionState && letter.object && letter.object.slotType) {
  const slotId = letter.object.slotType; // 'seed' | 'artifact' | 'folklore'
  // folklore → lore（兼容现有 slot 命名）
  const mappedSlotId = slotId === 'folklore' ? 'lore' : slotId;
  
  // ── Root H1: provenance 硬门槛 ──
  // 风土囊只接受已通过 object provenance 校验的物件
  // anchorText 必须存在且已通过 validateAnchorText 验证
  // 不允许用 name 作为 fallback
  if (!letter.object.anchorText) {
    console.log(`[mission] Object "${letter.object.name}" has no anchorText — enters collection only, not bag`);
    // 物件进图鉴但不进风土囊
    return;
  }
  
  // ── Root H3: 质量护栏 ──
  // 详见 §3.2.4
  if (!passesQualityGate(letter.object, beat, session, objectPoolForNode)) {
    console.log(`[mission] Object "${letter.object.name}" did not pass quality gate — enters collection only`);
    return;
  }
  
  if (missionState.slots[mappedSlotId]?.status === 'empty') {
    missionState = fillSlot(missionState, {
      slotId: mappedSlotId,
      encounterId: 'letter-object-classify',
      beat: beat.beat,
      nodeId: beat.nodeId,
      itemName: letter.object.name,
      itemDescription: letter.object.description,
      sourceLetterId: letter.id,
      sourceAnchorText: letter.object.anchorText, // 严格使用已验证的 anchorText，不 fallback
    });
  }
}
```

#### 3.2.2 填充策略

- **先到先得**：每个 slot 只填一次，第一个归类到该 slot 的物件占位（受质量护栏约束）
- **不强制三格全满**：旅程结束时可能只填了 1-2 格，这是正常的
- **保留 mission encounter 的叙事价值**：原有 9 个 mission encounter 去掉 `missionRelated` 标记后变成普通 encounter，它们的 promptHook 仍然会注入信件 prompt，引导 LLM 写出特定物件。只是不再通过 pendingFill 机制填充，而是通过 `letter.object.slotType` 自然归类

#### 3.2.3 Provenance 硬门槛（Root H1）

> **纪律：图鉴可以宽一点，风土囊必须更严。**

物件进入风土囊的前置条件：

| 条件 | 说明 | 不满足时的行为 |
|------|------|---------------|
| `letter.object.anchorText` 存在 | 物件必须有锚文本 | 只进图鉴，不进囊 + log |
| `anchorText` 已通过 `validateAnchorText` | 锚文本必须在信件正文中找到 | 只进图鉴，不进囊 + log |
| `letter.object.slotType` 存在 | LLM 必须标注了归类 | 只进图鉴，不进囊（graceful degradation） |

**明确禁止**：

- ❌ 不允许用 `letter.object.name` 作为 `sourceAnchorText` 的 fallback
- ❌ 不允许跳过 provenance 校验直接填充
- ❌ 不允许在 provenance MISS 时用任何替代文本顶替

**原因**：如果允许 name fallback，会重新打开"囊里有东西，但正文里未必真的长出来了"的后门。风土囊的每一格都应该能追溯到信件正文中的具体段落。

#### 3.2.4 质量护栏（Root H3）

> **纪律：防止太早、太泛、太路边的东西抢掉囊里位置。**

```typescript
function passesQualityGate(
  object: LetterObject,
  beat: BeatInfo,
  session: GameSession,
  nodeObjectPool?: ObjectPool,
): boolean {
  const journeyProgress = beat.beat / session.time.letterBeatsElapsed;
  
  // 规则 1：objectPool 命中的物件，任何时候都可以占位
  if (nodeObjectPool && isInObjectPool(object, nodeObjectPool)) {
    return true;
  }
  
  // 规则 2：旅程前 1/3，非 objectPool 物件不允许首次占位
  // 理由：旅程早期容易产出泛化物件（"一块石头""一根树枝"），
  //       让它们先进图鉴观察，不急着占囊位
  if (journeyProgress < 0.33) {
    return false;
  }
  
  // 规则 3：旅程中后期，非 objectPool 物件也可以占位
  // 此时如果囊位还空着，说明 objectPool 引导没有命中，
  // 允许自然产出的物件补位
  return true;
}

function isInObjectPool(object: LetterObject, pool: ObjectPool): boolean {
  // 检查物件名称是否与 objectPool 中的候选匹配
  // 使用模糊匹配：物件名包含候选名，或候选名包含物件名
  const candidates = [
    ...(pool.seed ?? []),
    ...(pool.artifact ?? []),
    ...(pool.folklore ?? []),
  ];
  return candidates.some(c => 
    object.name.includes(c.name) || c.name.includes(object.name)
  );
}
```

**质量护栏的效果**：

| 旅程阶段 | objectPool 命中 | 非 objectPool |
|----------|----------------|---------------|
| 前 1/3（探索期） | ✅ 可占位 | ❌ 只进图鉴 |
| 中 1/3（深入期） | ✅ 可占位 | ✅ 可占位 |
| 后 1/3（归途期） | ✅ 可占位 | ✅ 可占位 |

**概率影响**：质量护栏会略微降低三格全满概率（从 70-80% 降到约 60-70%），但换来的是囊里物件的质量更高、更有节点代表性。这是值得的取舍。

### 3.3 新的概率分析

| 步骤 | 概率 | 说明 |
|------|------|------|
| ① 信件附带物件 | ~30% per beat | shouldAttachObject 基础概率，含 pity 机制 |
| ② LLM 正确标注 slotType | ~95% | 三选一，LLM 几乎不会标错 |
| ③ 通过 provenance 硬门槛 | ~90% | anchorText 验证（已有机制，通过率高） |
| ④ 通过质量护栏 | ~70% | 前 1/3 旅程非 objectPool 物件被拦截 |
| ⑤ 对应 slot 尚空 | 递减 | 第一个物件 100%，后续递减 |

**16 拍旅程中物件产出数量**：16 × 30% ≈ **4.8 个物件**

**通过所有门槛的物件数量**：4.8 × 95% × 90% × 70% ≈ **2.9 个物件**

**三格全满概率**：约 **60-70%**（考虑 slotType 分布不均的情况）

> 对比旧机制的 2.7%，新机制即使加了 provenance 硬门槛和质量护栏，三格全满概率仍提升约 **22-26 倍**。

### 3.4 LetterObject 类型扩展

```typescript
export interface LetterObject {
  name: string;
  description: string;
  sourceLetterId?: string;
  sourceNodeId?: string;
  imageUrl?: string | null;
  iconType?: ItemIconType;
  anchorText?: string;
  /** V0.6b: 物件归类到风土囊的 slot 类型 */
  slotType?: 'seed' | 'artifact' | 'folklore';
}
```

### 3.5 UI 层变更

#### 3.5.1 CollectionPage（物件图鉴）

**不变**：继续遍历 `session.letters.filter(l => l.object)` 展示所有物件。

**新增**（Root S2）：页面顶部增加一句解释文案：

> "路上带回的所有东西"

与风土囊的文案形成对照：

> "风土囊里留下的三样"

**新增**：每个物件卡片上显示 slotType 标签。seed 和 artifact 使用物件图标，folklore 使用卷轴/札记图标（详见 §3.5.4）。

#### 3.5.2 MissionProgress（风土囊进度）

**不变**：继续读取 `session.missionState.slots` 展示三格状态。

数据源不变，只是填充方式从 pendingFill 链路改为 letter.object 归类。

**新增**：页面标题下方增加文案："风土囊里留下的三样"

#### 3.5.3 PostcardPage（明信片）

**不变**：继续从 `postcardData.missionProgress` 读取。farewell 生成时的 `buildMissionSection` 逻辑不变。

#### 3.5.4 folklore 呈现规范（Root H2）

> **纪律：folklore 不是实物，不要假装成实物。**

seed 和 artifact 是可以"揣兜里"的东西，folklore 是"记在心里"的东西。UI 必须体现这个区别。

| 维度 | seed / artifact | folklore |
|------|----------------|----------|
| **CollectionPage 卡片** | 物件卡片样式（现有样式） | 卷轴/札记样式：背景用羊皮纸色，边缘做旧，文字用手写体感觉 |
| **MissionProgress 格子** | 物件图标（🌱 / 🏺） | 卷轴图标（📜），格子标签改为"风土见闻"而非"风土" |
| **iconType 映射** | 保持现有 iconType | 新增 `scroll` / `note` iconType，或复用现有 `scroll` |
| **描述文案** | "聆带回了 {name}" | "聆记住了 {name}" 或 "聆听说了 {name}" |

**示例对比**：

- seed：🌱 沙枣核 —— "聆带回了沙枣核"
- artifact：🏺 风蚀石片 —— "聆带回了风蚀石片"
- folklore：📜 酸马奶的味道 —— "聆记住了酸马奶的味道"

### 3.6 节点圣经 objectPool 结构标准

新增到 `docs/NODE_BIBLE_STANDARD.md`：

```yaml
# 物件采样池（V0.6b 新增）
# 每个节点 3 类各 2-3 个候选，不是硬编码，是给 LLM 的引导
objectPool:
  seed:
    - name: 物件名称
      hint: 1-2 句描述，包含感官细节，帮助 LLM 在信件中自然写出
  artifact:
    - name: 物件名称
      hint: 1-2 句描述
  folklore:
    - name: 见闻名称
      hint: 1-2 句描述
```

**精修要求**：

- 每个节点的 objectPool 必须符合该节点的时代约束和地理特征
- seed 类必须是该地区实际存在的植物种子/果核
- artifact 类必须是该时代该地区可能出现的器物
- folklore 类必须是该地区独有的风俗/声音/味道/做法（不是实物）

---

## 四、实现路径

### Phase 1：P1 Bug 修复 + 类型扩展 + 护栏（CC 独立完成）

**改动范围**：

1. `engine/types.ts`：`LetterObject` 增加 `slotType` 字段
2. `engine/backlog.ts`：
   - 删除 line 340-382 的 pendingFill 消费逻辑
   - 新增物件归类逻辑（§3.2.1 的代码）
   - 新增 provenance 硬门槛（§3.2.3）
   - 新增质量护栏 `passesQualityGate`（§3.2.4）
3. `engine/mission-types.ts`：`PendingSlotFill` 类型保留但标记 deprecated
4. `data/encounters.yaml`：9 个 mission encounter 去掉 `missionRelated` 和 `grantSlot` 标记

**验收标准**：

- `pendingFill` 不再被创建和消费
- 带有 `slotType` + 合法 `anchorText` 的 `letter.object` 能正确填充 `missionState.slots`
- 无 `anchorText` 的物件只进图鉴，不进囊（provenance 硬门槛生效）
- 旅程前 1/3 的非 objectPool 物件只进图鉴，不进囊（质量护栏生效）
- 旧的 mission encounter 仍然作为普通 encounter 正常触发
- 现有测试不 break（mission-types.test.ts 中 fillSlot 测试仍通过）

### Phase 2：Prompt 改造 + 物件采样池（CC + 子敬协作）

**改动范围**：

1. `engine/letter-generator.ts`：
   - `OBJECT_ATTACHMENT_PROMPT` 增加 `slotType` 字段要求
   - `OBJECT_INSTRUCTION` 增加 `slotType` 字段要求
   - `parseLLMResponse` 解析 `slotType` 字段
2. `engine/prompts.ts`：
   - 当 `shouldAttachObject` 返回 true 且节点有 `objectPool` 时，注入采样池
3. `engine/node-bible.ts`：
   - `NodeBible` 类型增加 `objectPool` 字段
   - `parseNodeBible` 解析 `objectPool`
4. 节点圣经 YAML（3 个已定稿节点）：
   - `data/nodes/hexi_corridor.yaml` 增加 `objectPool`
   - `data/nodes/loulan.yaml` 增加 `objectPool`
   - `data/nodes/da_yuezhi.yaml` 增加 `objectPool`

**验收标准**：

- LLM 生成的物件包含 `slotType` 字段
- 有 `objectPool` 的节点，prompt 中包含采样池引导
- 无 `objectPool` 的节点（旧节点），物件仍然正常生成，`slotType` 由 LLM 自行判断

### Phase 3：UI 微调 + 集成测试

**改动范围**：

1. `src/pages/CollectionPage.tsx`：
   - 页面顶部增加"路上带回的所有东西"文案
   - 物件卡片增加 slotType 标签
   - folklore 物件使用卷轴/札记视觉样式（Root H2）
2. `src/components/MissionProgress.tsx`：
   - 增加"风土囊里留下的三样"文案
   - folklore 格子使用卷轴图标和"聆记住了"文案
3. 集成测试：Mock 模式下跑完整旅程，验证风土囊填充率

**验收标准**：

- 物件图鉴中每个物件显示 slotType 标签
- folklore 物件在视觉上与 seed/artifact 明显区分
- CollectionPage 和 MissionProgress 各有解释文案
- Mock 模式下 16 拍旅程，风土囊至少填充 2 格（概率 > 90%）

---

## 五、风险评估

### 5.1 技术风险

| 风险 | 等级 | 缓解措施 |
|------|------|----------|
| LLM 标注 slotType 不准确 | 低 | 三选一，且有采样池引导；即使标错，物件仍然进图鉴 |
| 旧 session 兼容性 | 中 | `slotType` 是 optional 字段，旧 session 的物件没有 slotType，不影响图鉴展示；风土囊对旧 session 仍显示空（与当前行为一致） |
| 物件产出分布不均（全是 artifact，没有 seed） | 中 | 节点采样池引导 + 后续可在 prompt 中加"当前风土囊还缺 seed"的提示 |
| 节点圣经 objectPool 精修工作量 | 低 | 只需精修 3 个已定稿节点，其他节点用旧逻辑 fallback |
| provenance 硬门槛导致填充率过低 | 低 | 现有 validateAnchorText 通过率约 90%；如果实测过低，可调整但不可取消门槛 |

### 5.2 产品风险

| 风险 | 等级 | 缓解措施 |
|------|------|----------|
| 风土囊变得"太容易满" | 低 | 质量护栏 + provenance 硬门槛 + 物件产出本身有概率控制（30% base） |
| 失去 mission encounter 的叙事仪式感 | 中 | mission encounter 保留为普通 encounter，promptHook 仍然注入，只是不再有"使命触发"的特殊标记 |
| 用户感知不到"风土囊在填充" | 低 | MissionProgress 组件已有实时展示；可在信件详情页增加"这个物件进了风土囊"的提示 |
| folklore 和实物混淆 | 低（已缓解） | Root H2 要求 folklore 使用卷轴/札记视觉，与实物明确区分 |

### 5.3 回滚方案

- Phase 1 的改动集中在 `backlog.ts`，可通过 git revert 回滚
- `slotType` 是 optional 字段，回滚后旧逻辑仍可工作
- 节点圣经的 `objectPool` 是新增字段，不影响现有逻辑

---

## 六、验收口径卡

### 核心目标

> 风土囊的三格（种子/器物/风土见闻）从信件中自然长出来，而不是依赖一条脆弱的 mission encounter → provenance 匹配链路。

### 3 个必须通过的真实用例

1. **正常旅程**：跑完 16 拍主线，风土囊至少填充 2 格（对比旧机制几乎全空）
2. **物件归类正确**：LLM 生成的"葡萄籽"归类到 seed，"火石"归类到 artifact，"烤饼做法"归类到 folklore
3. **图鉴和风土囊一致**：物件图鉴中显示的物件，如果有 slotType 且通过了 provenance 校验，在风土囊对应格子中也能看到

### 2 个不能破坏的旧行为

1. **物件图鉴正常工作**：所有 `letter.object` 仍然进图鉴，不丢失（图鉴不受 provenance 门槛和质量护栏影响）
2. **farewell / postcard 正常工作**：旅程结束时 farewell 信件正常生成，postcard 页面正常展示风土囊结果

### 1 个最容易被 agent "做假"的点

- **slotType 标注质量**：agent 可能在测试中硬编码 slotType 而不是真正让 LLM 标注。验收时需要用真实 LLM（非 Mock）跑至少 3 封带物件的信件，检查 slotType 是否合理。

### 失败时应该怎么表现

- 如果 LLM 没有返回 slotType 字段：物件正常进图鉴，但不归类到风土囊（graceful degradation）
- 如果 anchorText 未通过 provenance 校验：物件正常进图鉴，但不进风土囊 + console log
- 如果 slotType 对应的 slot 已满：物件正常进图鉴，风土囊不变（先到先得）
- 如果物件未通过质量护栏：物件正常进图鉴，但不进风土囊 + console log
- 不应该出现：物件丢失、风土囊状态异常、farewell 崩溃

### Litch 最终验收方式

1. 在线上版本跑一轮完整旅程（真实 LLM 模式）
2. 检查物件图鉴和风土囊是否一致
3. 检查 farewell 明信片上风土囊的展示
4. 确认 folklore 物件在 UI 上与 seed/artifact 有明显视觉区分

---

## 七、与 T4 Prompt 重构的关系

本 spec 的 Phase 2（Prompt 改造）与 `docs/NOONPOST_PROMPT_REDESIGN.md`（T4 信件 prompt 重构）有交叉：

- T4 改 SYSTEM_PROMPT 的文风（"简白史笔" → "小动物写日记"）
- 本 spec 改 OBJECT_ATTACHMENT_PROMPT 的物件指令（增加 slotType + 采样池）

**建议**：T4 和本 spec 的 Phase 2 合并为一个 PR，避免 prompt 改两次。CC 实现时先做 T4 的 SYSTEM_PROMPT 改造，再做本 spec 的物件 prompt 改造。

---

## 八、开放问题（Root 评审后更新）

Root 评审已回答了部分开放问题，剩余问题标注状态：

| # | 问题 | 状态 | Root 意见 / 处理 |
|---|------|------|-----------------|
| 1 | mission encounter 是否完全废弃 missionRelated 标记？ | **待定** | 保留标记但降级为普通 encounter；是否作为"加权引导"让 encounter 引擎更倾向于触发物件信件，留到实测后决定 |
| 2 | slotType 的 fallback 分类规则（基于 iconType 映射） | **暂不做** | Root H1 明确不允许 name fallback；如果 LLM 没返回 slotType，物件只进图鉴不进囊，不做 iconType 映射 |
| 3 | 风土囊是否需要"升级"机制？ | **V1 不做** | 先到先得 + 质量护栏已足够；升级机制留到 V0.7+ 视实测数据决定 |
| 4 | 物件产出分布不均的兜底 | **Phase 2 后观察** | 先看 objectPool 引导效果；如果实测分布严重不均，再加"当前风土囊还缺 X"的 prompt 提示 |

---

## 附录 A：当前代码关键路径索引

| 文件 | 行号 | 内容 |
|------|------|------|
| `engine/backlog.ts` | 37-51 | `findAnchorInContent`（待废弃） |
| `engine/backlog.ts` | 57-68 | `extractContextAroundAnchor`（待废弃） |
| `engine/backlog.ts` | 284-295 | mission encounter → pendingFill 创建（待废弃） |
| `engine/backlog.ts` | 340-382 | pendingFill 消费 + provenance 匹配（待替换） |
| `engine/letter-generator.ts` | 46-64 | `shouldAttachObject`（不变） |
| `engine/letter-generator.ts` | 86-97 | `OBJECT_ATTACHMENT_PROMPT`（待修改） |
| `engine/prompts.ts` | 297-304 | `OBJECT_INSTRUCTION`（待修改） |
| `engine/mission-types.ts` | 全文 | MissionState / fillSlot / computeMissionOutcome（不变） |
| `engine/farewell.ts` | 81-96 | `buildMissionSection`（不变） |
| `src/pages/CollectionPage.tsx` | 20-29 | 物件图鉴读取逻辑（微调） |
| `src/components/MissionProgress.tsx` | 全文 | 风土囊三格展示（不变） |
| `data/encounters.yaml` | mission 区块 | 9 个 mission encounter（去掉 missionRelated 标记） |
| `data/missions.yaml` | 全文 | mission 定义（不变） |

## 附录 B：节点圣经 objectPool 示例（河西走廊）

```yaml
objectPool:
  seed:
    - name: 沙枣核
      hint: 沙枣表面银白粉末，入口干涩，嚼后微甜。核很硬，也许能种
    - name: 骆驼刺种子
      hint: 骆驼刺的荚果裂开后掉出来的小粒，干燥坚硬，捏在指尖像小石子
  artifact:
    - name: 风蚀石片
      hint: 被风削成薄片的石头，边缘锋利，可以切东西。拿在手里很轻
    - name: 旧皮水囊
      hint: 别人丢下的水囊，摇了摇还有水声，囊口系着一截旧皮绳
    - name: 匈奴箭镞
      hint: 沙地里翻出来的铜箭头，三棱形，已经锈绿了，但棱角还在
  folklore:
    - name: 酸马奶的味道
      hint: 匈奴人把马奶发酵了喝，酸得能让人皱一天的脸，但喝完肚子暖暖的
    - name: 匈奴岩画
      hint: 石壁上刻着奔跑的马和弯弓的人，线条粗犷，有些地方被风沙磨平了
    - name: 夜间驼铃声
      hint: 远处传来叮叮当当的声音，是商队在夜里赶路，不敢白天走
```
