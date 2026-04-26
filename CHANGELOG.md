# Changelog

All notable changes to this skill will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] — 2026-04-26

### Added
- Per-dimension subscores in review output (clarity / evidence / strategic fit / risk awareness / narrative)
- **Inline annotations** mode: review now walks through the doc section by section, quoting snippets and adding leader-voice margin comments
- **Confidence note** at the end of every review, labeling how grounded the simulation is in actual logged data
- Auto-recommendation of relevant leaders based on doc content (instead of asking "which leader?" cold)
- Adversarial review suggestion: if logged interactions reveal disagreement between two leaders, the skill proactively offers a contrasting second perspective
- Project-Knowledge setup walkthrough in `SKILL.md`

### Changed
- "What you should change" list now explicitly prioritized (highest-leverage fix first)
- "If you don't change anything" prediction expanded to include trust-capital outcomes, not just approve/reject

## [0.1.0] — 2026-04-26

Initial release.

### Added
- Three operating modes: Review, Log, Manage
- `leaders.json` schema (`references/schema.md`)
- Review craft guide (`references/review_craft.md`) — how to avoid sycophancy, generic-MBA-voice, and hedge mush
- Starter template at `assets/leaders_template.json`
- Multi-leader review chains in escalation order
- Rolling-window cap of ~20 interactions per leader, with pattern extraction
- Honest-uncertainty labeling when profile data is sparse
