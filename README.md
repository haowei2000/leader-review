# leader-review

**English** | [简体中文](README.zh.md)

> A Claude skill that simulates your real-life leaders reviewing your work — and gets sharper over time as you log real interactions.

[![Skill Format](https://img.shields.io/badge/Claude-Skill-7c3aed)](https://docs.claude.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## What this is

You're about to send a doc to your manager. Or your skip-level. Or three leaders in a chain. You want to know: **what will they actually push back on?**

`leader-review` is a [Claude skill](https://docs.claude.com/en/docs/build-with-claude/skills) that:

- **Simulates a review** from a specific leader, in their voice, with their priorities, their red flags, and their decision style
- **Logs day-to-day interactions** — what they said in the 1:1, the comment they left on your last doc, the quote you want to remember — and uses those logs to make future simulations sharper
- **Runs review chains** — direct manager → skip → exec — so you can see how the doc needs to evolve to survive the journey, not just the first reader
- **Stays honest about uncertainty** — when the profile is thin, it labels the review as "extrapolating" instead of pretending to know

All your data lives in a single `leaders.json` file that **you control**. No server-side storage, no vendor lock-in.

## Why this exists

Most "review my doc" prompts get you generic management feedback. "Make sure the ask is clear, consider the audience, watch your tone." Useless.

The reason is that good review *of your work* requires knowing *your specific reader*. Sarah-the-VP-of-Product reviews differently from David-the-VP-of-Engineering, and your direct manager reviews differently from both. They have different priorities, different triggers, different things they say in 1:1s, different ways they signal "I'm not actually convinced."

This skill gives Claude a place to store all of that, and a structured way to use it.

## What a review looks like

When you ask "have Sarah review this", you get:

```
## Sarah Chen reviewing: Q3 Pricing Proposal

Gut reaction (first 30 seconds of reading): ...

Score: 6/10 — "Diagnosis is right, but you're hiding the ask."
- Clarity of ask: 4/10
- Evidence / rigor: 7/10
- Strategic fit: 8/10
- Risk awareness: 5/10
- Narrative & flow: 6/10

Inline annotations:
> "We believe a 15% increase is appropriate given..."
  — "Believe? Either you've modeled it or you haven't. Which is it?"

> "There are several approaches we could take..."
  — "Pick one. I don't read menus."

What works: ...
What lands wrong: ...
Questions she'd ask you: ...
What you should change before sending: ...
If you don't change anything: She approves but loses 5% trust capital. Worse than rejection.

Confidence note: High — anchored in 4 logged reactions to similar pricing docs.
```

The voice and the questions come from her actual logged behavior, not from a generic "blunt VP" template.

## Quick start

### 1. Install

Download `leader-review.skill` from the [latest release](../../releases) (or [build it yourself](#build-from-source)), then upload it to Claude:

- **Claude.ai**: Settings → Capabilities → Skills → Upload
- **Claude Code / API**: see [Anthropic's skills docs](https://docs.claude.com/en/docs/build-with-claude/skills)

### 2. Set up your data file

Copy [`examples/leaders.starter.json`](examples/leaders.starter.json) and rename to `leaders.json`. Edit the example leader to match one of your real leaders — even a half-filled profile is useful to start.

### 3. Recommended: put it in a Claude Project

The skill works best when `leaders.json` is always in scope:

1. Create a Claude Project (e.g. "Leader Review")
2. Add the `leader-review` skill to the Project
3. Upload `leaders.json` to the Project's Knowledge
4. Open new chats from inside that Project

Now `leaders.json` is automatically available, and any updates the skill produces can be saved back to Knowledge.

### 4. Use it

Try one of:

- *"Have my manager review this doc"* → upload doc, get a review
- *"What would the VP think of this?"* → review from skip-level
- *"Run this through Sarah, then David"* → review chain
- *"My manager said today that he hates how I bury the ask. Log that."* → updates the profile
- *"Show me what we have on Sarah"* → inspect the profile
- *"Add a new leader: Mark, our new CTO"* → bootstrap a new profile via interview

The skill auto-triggers on these phrasings — you don't need to call it by name.

## Repo layout

```
leader-review/
├── leader-review/              ← the skill itself (this is what gets packaged)
│   ├── SKILL.md                ← entry point, triggering metadata, mode logic
│   ├── assets/
│   │   └── leaders_template.json
│   └── references/
│       ├── schema.md           ← leaders.json schema documentation
│       └── review_craft.md     ← how to write a non-generic review
├── examples/
│   ├── leaders.starter.json    ← minimal starter file
│   └── leaders.full.json       ← richer example showing all fields populated
├── scripts/
│   └── build.sh                ← packages the skill into leader-review.skill
├── docs/
│   ├── installation.md
│   ├── usage.md
│   └── privacy.md
├── CHANGELOG.md
├── LICENSE
└── README.md
```

## Build from source

```bash
git clone https://github.com/<your-handle>/leader-review.git
cd leader-review
./scripts/build.sh
# → outputs leader-review.skill in the repo root
```

The build script just zips the `leader-review/` folder with the right structure. No build dependencies beyond `zip`.

## Privacy & data handling

Your `leaders.json` contains candid characterizations of real people. **Treat it like a journal, not like a public document.**

- Don't commit your real `leaders.json` to a public repo. The included `.gitignore` excludes `leaders.json` (only `leaders.starter.json` and `leaders.full.json` under `examples/` are tracked).
- Don't paste it into chats outside your private Claude Project unless you mean to.
- If you stop using the skill, delete the file from your Project knowledge — the skill has no other copy.

See [`docs/privacy.md`](docs/privacy.md) for a fuller discussion.

## Design choices

A few things that may not be obvious:

- **Single JSON file, not a database.** You can read, edit, version-control, and delete it yourself. The skill never "owns" your data.
- **Rolling window on interactions.** `recent_interactions` caps at ~20 per leader. Older events that revealed lasting patterns get promoted to `feedback_patterns`, so dropping the raw entry doesn't lose signal.
- **Honest uncertainty.** When the profile is sparse, the skill labels its review as "extrapolating" rather than performing confidence it doesn't have. This matters: a confident-sounding generic review is *worse* than no review.
- **Not a manipulation tool.** This is for pressure-testing your own work, not for figuring out how to play your boss. The skill explicitly redirects requests in that direction.

## Contributing

Issues and PRs welcome. Particularly interested in:

- Improvements to `review_craft.md` — examples of voices that worked / didn't
- New leader archetypes worth adding to the template
- Bug reports where the simulation felt off (with enough detail to learn from — what kind of leader, what kind of doc, what the skill said vs what the real reader said)

## License

MIT. See [LICENSE](LICENSE).

## Acknowledgements

Built with the [Claude skill format](https://docs.claude.com/en/docs/build-with-claude/skills). The structural patterns (progressive disclosure, mode switching, reference docs) follow Anthropic's skill-creator conventions.
