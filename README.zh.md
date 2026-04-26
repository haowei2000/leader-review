# leader-review

[English](README.md) | **简体中文**

> 一个 Claude 技能，用于模拟你现实中的领导评审你的工作——并随着你记录真实互动而变得越来越精准。

[![Skill Format](https://img.shields.io/badge/Claude-Skill-7c3aed)](https://docs.claude.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 这是什么

你正准备把一份文档发给你的直属经理，或者越级领导，又或者要经过三层领导的链路。你想知道：**他们到底会在什么地方给你打回来？**

`leader-review` 是一个 [Claude 技能](https://docs.claude.com/en/docs/build-with-claude/skills)，它可以：

- **模拟评审**——以特定领导的口吻、按他们的优先级、抓他们的红线、用他们的决策风格
- **记录日常互动**——他们在 1:1 中说了什么、在你上一份文档上留下的批注、那句你想记住的话——并用这些记录让未来的模拟更精准
- **跑评审链**——直属经理 → 越级 → 高管——这样你就能看到这份文档需要怎样演进，才能撑过整条链路，而不仅仅是第一位读者
- **对不确定性保持诚实**——当画像信息不足时，它会把评审标记为"外推推测"，而不是装作了解

你的所有数据都存在一个 `leaders.json` 文件里，**完全由你掌控**。无服务端存储、无供应商锁定。

## 为什么需要它

大多数"帮我看看这份文档"的提示词只能给你一些泛泛的管理建议："让你的诉求清晰一些，考虑一下受众，注意你的语气。"——毫无用处。

原因在于，对你工作的好评审需要了解**你具体的那位读者**。Sarah——这位产品 VP——和 David——这位工程 VP——评审起来风格完全不同；你的直属经理评审起来又和他们都不一样。他们有不同的优先级、不同的雷区、不同的 1:1 口头禅、不同的方式来表达"我其实没被说服"。

这个技能就是给 Claude 一个地方去存储这些信息，再给一套结构化的方式去使用它们。

## 一份评审长什么样

当你说"让 Sarah 来评审一下这个"，你会得到：

```
## Sarah Chen 评审：Q3 定价提案

第一感觉（阅读前 30 秒）：……

总分：6/10 ——"诊断是对的，但你把诉求藏起来了。"
- 诉求清晰度：4/10
- 论据 / 严谨性：7/10
- 战略契合度：8/10
- 风险意识：5/10
- 叙事与流畅度：6/10

行内批注：
> "我们认为 15% 的涨价是合适的，因为……"
  ——"认为？你到底建过模没有？是哪种？"

> "我们可以采取几种不同的做法……"
  ——"选一个。我不读菜单。"

哪些地方是有效的：……
哪些地方让人不适：……
她会问你的问题：……
你在发出去之前应该改什么：……
如果你什么都不改：她会批准，但你会损失 5% 的信任值。这比被驳回更糟。

置信度说明：高——基于 4 条针对类似定价文档的真实记录反应。
```

声音和问题来自她真实记录下来的行为，而不是某个泛化的"直率 VP"模板。

## 快速上手

### 1. 安装

从[最新发布版本](../../releases)下载 `leader-review.skill`（或者[自己构建](#从源码构建)），然后上传到 Claude：

- **Claude.ai**：设置 → Capabilities → Skills → 上传
- **Claude Code / API**：参见 [Anthropic 的 skills 文档](https://docs.claude.com/en/docs/build-with-claude/skills)

### 2. 准备你的数据文件

复制 [`examples/leaders.starter.json`](examples/leaders.starter.json) 并重命名为 `leaders.json`。把示例里的领导改成你的某位真实领导——哪怕只填了一半的画像也已经很有用了。

### 3. 推荐：放进一个 Claude Project

当 `leaders.json` 一直在上下文里时，这个技能效果最好：

1. 创建一个 Claude Project（例如"Leader Review"）
2. 把 `leader-review` 技能加入这个 Project
3. 把 `leaders.json` 上传到 Project 的 Knowledge
4. 在这个 Project 内开新对话

这样 `leaders.json` 就会自动可用，技能产生的任何更新也都能保存回 Knowledge。

### 4. 使用

试试这些说法：

- *"让我经理评审一下这份文档"* → 上传文档，得到一份评审
- *"VP 会怎么看这个？"* → 来自越级领导的评审
- *"先给 Sarah 看，再给 David 看"* → 评审链
- *"我经理今天说他烦我把诉求埋在最下面。记下来。"* → 更新画像
- *"展示一下我们关于 Sarah 已有的信息"* → 查看画像
- *"加一位新领导：Mark，我们的新 CTO"* → 通过访谈方式建立新画像

技能会基于这些表达自动触发——你不需要按名字调用它。

## 仓库结构

```
leader-review/
├── leader-review/              ← 技能本体（这部分会被打包）
│   ├── SKILL.md                ← 入口、触发元数据、模式逻辑
│   ├── assets/
│   │   └── leaders_template.json
│   └── references/
│       ├── schema.md           ← leaders.json schema 文档
│       └── review_craft.md     ← 如何写一份不泛化的评审
├── examples/
│   ├── leaders.starter.json    ← 最小化起步文件
│   └── leaders.full.json       ← 字段填充更完整的示例
├── scripts/
│   └── build.sh                ← 打包技能为 leader-review.skill
├── docs/
│   ├── installation.md
│   ├── usage.md
│   └── privacy.md
├── CHANGELOG.md
├── LICENSE
└── README.md
```

## 从源码构建

```bash
git clone https://github.com/<your-handle>/leader-review.git
cd leader-review
./scripts/build.sh
# → 在仓库根目录输出 leader-review.skill
```

构建脚本只是用正确的结构把 `leader-review/` 文件夹打成 zip。除了 `zip`，没有其他构建依赖。

## 隐私与数据处理

你的 `leaders.json` 里包含了对真实人物的坦率刻画。**把它当作一本日记，而不是一份公开文档。**

- 不要把你真实的 `leaders.json` 提交到公开仓库。仓库自带的 `.gitignore` 已经忽略了 `leaders.json`（只追踪 `examples/` 下的 `leaders.starter.json` 和 `leaders.full.json`）。
- 不要把它粘贴到你私有 Claude Project 之外的对话里——除非你确实想这么做。
- 如果你不再使用这个技能，把文件从 Project knowledge 里删除——技能本身没有任何其它副本。

更完整的讨论参见 [`docs/privacy.md`](docs/privacy.md)。

## 设计取舍

有几个可能不太显然的点：

- **单一 JSON 文件，而不是数据库。** 你可以自己读、改、做版本管理、删除。技能从来不"占有"你的数据。
- **互动记录采用滚动窗口。** `recent_interactions` 每位领导大约只保留 20 条。那些揭示了长期模式的旧事件会被晋升到 `feedback_patterns`，所以丢掉原始条目并不会丢失信号。
- **诚实的不确定性。** 当画像稀疏时，技能会把它的评审标记为"外推推测"，而不是装出它没有的自信。这一点很重要：一份听起来很自信的泛化评审比没有评审*更糟*。
- **不是用来"操纵"的工具。** 这是用来对你自己的工作做压力测试的，不是用来研究怎么"摆平"老板的。技能会显式地拒绝这类方向的请求。

## 贡献

欢迎 issue 和 PR。我们尤其欢迎：

- 对 `review_craft.md` 的改进——哪些声音模拟得好 / 不好的例子
- 值得加入模板的新领导原型
- 模拟感觉不对的 bug 报告（要有足够细节让我们能学到东西——什么样的领导、什么样的文档、技能说了什么、真实读者实际说了什么）

## 许可

MIT。见 [LICENSE](LICENSE)。

## 致谢

基于 [Claude skill 格式](https://docs.claude.com/en/docs/build-with-claude/skills) 构建。结构模式（渐进披露、模式切换、参考文档）遵循 Anthropic 的 skill-creator 约定。
