# Installation

## Option A: Download a release (recommended)

1. Go to the [releases page](../../releases) and download the latest `leader-review.skill`.
2. In Claude.ai, go to **Settings → Capabilities → Skills**.
3. Click **Upload skill** and select the `.skill` file.
4. The skill is now available across your conversations.

## Option B: Build from source

If you've cloned the repo and made local edits:

```bash
git clone https://github.com/<your-handle>/leader-review.git
cd leader-review
./scripts/build.sh
```

This produces `leader-review.skill` in the repo root. Upload it the same way as Option A.

The build script just zips the `leader-review/` folder. No external dependencies beyond `zip` (preinstalled on macOS and most Linux distributions).

## Setting up your data

1. Copy `examples/leaders.starter.json` to a new file called `leaders.json` (anywhere outside the repo, since `.gitignore` excludes it).
2. Edit it to describe one of your real leaders. You don't need to fill every field — even just `name`, `role`, `current_priorities`, and `red_flags` is enough to start.
3. **Strongly recommended**: create a Claude Project named "Leader Review" (or whatever), add the skill to the Project, and upload `leaders.json` to the Project's Knowledge. Always open new chats from inside that Project.

This is the cleanest workflow because:

- The skill always sees `leaders.json` automatically
- You can paste-back the updated `leaders.json` into Knowledge after each Log operation
- Your sensitive notes about real people stay scoped to one place

## Verifying it works

Open a new chat in your Project and try:

> "Show me what we have on [your leader's name]."

If the skill responds with a structured summary of the profile fields, you're set. If it asks "do you have a `leaders.json` file?", check that the file is actually in the Project's Knowledge (not just attached to one chat).

## Updating

When a new release ships:

1. Download the new `.skill` file
2. In Claude.ai → Settings → Skills, remove the old version
3. Upload the new one
4. Your `leaders.json` is unaffected — it's your data, not the skill's

The schema may evolve over time. The `version` field at the top of `leaders.json` lets future versions of the skill handle older files gracefully.
