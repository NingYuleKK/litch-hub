# Seedream API 接入说明书

本文档面向 Noonpost 项目团队成员（CC、Codex、奉孝等 Agent），旨在提供 Seedream 图片生成能力的快速接入指南。

## 1. 概述

Seedream 是字节跳动推出的图片生成与编辑模型。在 Noonpost（半日来信）项目中，我们需要为小动物远行丝绸之路定期寄回的来信生成配图。经过验证，**Seedream 5.0 Lite** 模型非常适合我们的需求。

选择 Seedream 的主要原因包括：
*   **中文 Prompt 原生支持**：作为国产大模型，对中文语境和文化元素的理解极佳，无需翻译即可直接使用中文信件内容作为 Prompt。
*   **水墨插画风格表现优异**：能够很好地生成符合项目设定的“西域水墨插画风格”配图。
*   **成本可控**：单张图片生成成本约为 0.22 元，适合长期稳定运行。
*   **支持参考图锁风格**：支持图生图功能，未来可以通过 2-3 张基准图锁定整体视觉风格的一致性。

## 2. API 配置

我们通过国内的**火山方舟 (Volcengine Ark)** 平台接入 Seedream API。

*   **平台**：火山方舟 (Volcengine Ark)
*   **Base URL**：`https://ark.cn-beijing.volces.com/api/v3`
*   **需要的凭证**：
    *   `ARK_API_KEY`：用于身份验证的 API 密钥。
    *   `ARK_ENDPOINT_ID`：模型接入点的唯一标识符（对应 Seedream 5.0 Lite 模型）。

**凭证获取方式**：
1.  登录火山引擎控制台，进入“火山方舟”大模型服务平台。
2.  在“API Key 管理”页面创建并获取 `ARK_API_KEY`。
3.  在“在线推理”页面创建 Seedream 5.0 Lite 模型的接入点，获取对应的 `ARK_ENDPOINT_ID`。

> **注意**：请勿将 API Key 硬编码在代码中，务必通过环境变量（如 `os.getenv("ARK_API_KEY")`）进行读取，以确保安全性。

## 3. 调用方式

火山方舟提供了兼容 OpenAI 格式的 SDK，我们可以直接使用 `openai` Python 库进行调用。

### 3.1 关键参数说明

*   `model`：传入获取到的 `ARK_ENDPOINT_ID`。
*   `prompt`：图片生成的文本描述（支持中文，最高 600 个英文单词）。
*   `size`：图片分辨率。支持预设值（如 `"2K"`, `"4K"`）或自定义像素尺寸（如 `"2048x2048"`）。
*   `output_format`：输出图片格式，建议使用 `"png"` 或 `"jpeg"`。
*   `response_format`：响应格式，建议使用 `"url"`，API 将返回图片的下载链接。
*   `extra_body`：扩展参数。建议设置 `{"watermark": False}` 以关闭默认的水印。

### 3.2 Python 调用示例

```python
import os
from openai import OpenAI

# 1. 从环境变量读取配置
api_key = os.getenv("ARK_API_KEY")
endpoint_id = os.getenv("ARK_ENDPOINT_ID")

# 2. 初始化 OpenAI 客户端，指向火山方舟 Base URL
client = OpenAI(
    api_key=api_key,
    base_url="https://ark.cn-beijing.volces.com/api/v3"
)

# 3. 调用 API 生成图片
response = client.images.generate(
    model=endpoint_id,
    prompt="黄昏时分，一只小猫背着行囊走在河西走廊的戈壁上，远处是连绵的祁连山脉，天边晚霞如火，水墨插画风格，温暖色调",
    size="2K",
    output_format="png",
    response_format="url",
    extra_body={
        "watermark": False,
    }
)

# 4. 获取图片 URL
image_url = response.data[0].url
print(f"图片 URL: {image_url}")
```

## 4. Noonpost 场景最佳实践

为了在 Noonpost 项目中获得最佳的生成效果，建议遵循以下实践指南。

### 4.1 Prompt 模板建议

Prompt 的构建应包含三个核心部分：**旅行者形象 + 节点环境/来信内容 + 风格锁定词**。

*   **旅行者形象描述模板**：保持主角形象的一致性。例如："一只可爱的耳廓狐背着小包袱"、"一只橘猫穿着旅行披风"。
*   **节点环境/来信内容**：提取信件中的关键场景和氛围。例如："走在河西走廊的戈壁上，远处是连绵的祁连山脉，天边晚霞如火"。
*   **推荐的风格锁定关键词**：在 Prompt 末尾固定添加：`"水墨插画风格，温暖色调，丝绸之路西域风情"`。

**完整 Prompt 示例**：
> 一只可爱的耳廓狐背着小包袱，走在河西走廊的戈壁上，远处是连绵的祁连山脉，天边晚霞如火，水墨插画风格，温暖色调，丝绸之路西域风情。

### 4.2 参考图生图功能说明

为了进一步提升不同信件配图之间风格的一致性，未来版本计划引入参考图生图功能。
我们可以预先筛选 2-3 张高质量的“西域水墨插画”作为基准图。在调用 API 时，将这些基准图作为参考输入，Seedream 将在生成新图片时严格参考这些基准图的画风和色调。

## 5. 注意事项

1.  **异步生成**：Seedream 图片生成耗时通常在 **30-40 秒**左右。在 Noonpost 后端架构中，务必采用**异步任务**（如 Celery 或消息队列）来处理图片生成请求，避免阻塞主线程。
2.  **计费规则**：API 采用按成功生成的图片张数计费。如果因为 Prompt 违规导致审核失败，**不收费**。
3.  **图片保存**：API 返回的图片 URL 有效期通常为 **24 小时**。获取到 URL 后，必须立即将图片下载并转存到我们自己的 OSS（对象存储）中，不要直接在前端使用原始 URL。
4.  **安全规范**：再次强调，`ARK_API_KEY` 必须通过环境变量注入，严禁提交到代码仓库。

## 6. 测试验证

项目中已提供完整的测试脚本 `test_seedream.py`，可用于快速验证 API 是否可用及配置是否正确。

**测试步骤**：

1.  确保已安装依赖：`pip install openai requests`
2.  设置环境变量：
    ```bash
    export ARK_API_KEY="你的火山方舟API_KEY"
    export ARK_ENDPOINT_ID="你的Seedream模型Endpoint_ID"
    ```
3.  运行测试脚本：
    ```bash
    python3 test_seedream.py
    ```
4.  如果配置正确，脚本将输出生成耗时，并将生成的图片保存为当前目录下的 `seedream_test_output.png`。

## 7. 成本估算

根据 Noonpost 项目 V0.6 版本的规划，我们可以进行如下成本估算：

*   **单价**：Seedream 5.0 Lite 约为 0.22 元 / 张。
*   **使用频率**：每封来信生成 1 张配图，预计每天 1-2 封信。
*   **日成本**：0.22 元 ~ 0.44 元。
*   **月成本 (30天)**：约 **6.6 元 ~ 13.2 元**。

整体来看，每月 7-14 元的图片生成成本完全在项目可控范围内，且能显著提升产品的视觉体验。
