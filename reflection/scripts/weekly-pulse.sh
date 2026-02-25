#!/bin/bash
# Litch's Reflection - 3-Day Cognitive Pulse Check
# 每周检查过去3天的对话，生成认知洞察

REFLECTION_DIR="/Users/litch/.openclaw/workspace/litch-hub/reflection"
TODAY=$(date +%Y-%m-%d)
REPORT_FILE="$REFLECTION_DIR/pulse/weekly-pulse-$(date +%Y-%m-%d).md"

# 过去3天的日期
DATE_3DAGO=$(date -v-3d +%Y-%m-%d 2>/dev/null || date -d "3 days ago" +%Y-%m-%d)
DATE_2DAGO=$(date -v-2d +%Y-%m-%d 2>/dev/null || date -d "2 days ago" +%Y-%m-%d)
DATE_1DAGO=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "1 day ago" +%Y-%m-%d)

echo "=== Litch's Cognitive Pulse Check ==="
echo "检查周期: $DATE_3DAGO ~ $TODAY"
echo ""

# 1. 读取过去3天的Reflection内容
CONTENT=""
for date in $DATE_3DAGO $DATE_2DAGO $DATE_1DAGO; do
    if [ -f "$REFLECTION_DIR/2026-02.md" ]; then
        # 提取该日期相关的内容
        CONTENT="$CONTENT$(grep -A 200 "$date" "$REFLECTION_DIR/2026-02.md" 2>/dev/null | head -100)"
    fi
done

# 2. 简单分析（基于关键词频率）
echo "📊 过去3天主题回顾:"
echo ""

# 提取关键主题词
if [ -n "$CONTENT" ]; then
    echo "$CONTENT" | grep -o "主题:[^#]*" | head -5
    echo ""
    echo "$CONTENT" | grep -o "关键词:[^#]*" | head -5
else
    echo "(暂无记录)"
fi

echo ""
echo "---"

# 3. 生成结构化报告
cat > "$REPORT_FILE" << EOF
# Weekly Cognitive Pulse
**检查周期**: $DATE_3DAGO ~ $TODAY  
**生成时间**: $(date +%Y-%m-%d\ %H:%M)

---

## 📊 过去3天主题回顾

*(待奉孝手动填写)*

### 重复出现的主题
-

### 反复出现但未解决的问题
-

### 新出现的 Insight
-

---

## 🧠 身心状态观察

*(观察 Litch 的用词、情绪基调)*

- 

---

## 🎯 下一个3天建议关注

*(奉孝给出的建议)*

- 

---

*这是每周轻量级认知体检。完整的深度复盘见 2026-02.md*
EOF

echo "✅ 报告已生成: $REPORT_FILE"

# 4. 提示用户填写
echo ""
echo "📝 建议打开报告手动补充:"
echo "$REPORT_FILE"
