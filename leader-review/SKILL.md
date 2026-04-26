---
name: leader-review
description: Simulate the user's real-life leaders (manager, skip-level, cross-functional partners) reviewing the user's documents, plans, proposals, or product work. Also maintain leader profiles by ingesting day-to-day interactions, feedback, and quotes the user logs over time. Use this skill whenever the user asks to "have my boss review", "what would [name] say about this", "score this from my leader's perspective", "do a pre-mortem before I send this to leadership", "log what my manager said today", "update my boss's profile", or anything similar — even if they don't say the word "leader" or "review". If the user mentions a specific leader by name and wants feedback, critique, scoring, or wants to record an interaction, this skill applies.
---

# Leader Review

This skill helps the user pressure-test their work the way their actual leaders would, and grows sharper over time as the user logs real interactions.

The skill has three modes. Figure out which mode the user is in, then follow the matching section.

| Mode | Triggers |
|---|---|
| **Review** | User wants their work evaluated by one or more leaders. "What would Sarah think of this?", "Score this deck", "Pre-mortem before I send this up." |
| **Log** | User is recording something that happened. "My boss said X today", "Mark hated my last proposal because of Y", "Update David's profile — he just got promoted to VP." |
| **Manage** | User is setting up, viewing, or editing leader profiles. "Add a new leader", "Show me what we have on Sarah", "I want to start using this." |

## The data file

All state lives in a single JSON file: `leaders.json`. The user keeps this file themselves — typically in their Claude Project knowledge, or pasted into the chat, or uploaded as an attachment. There is no server-side storage.

**Recommended setup (mention this once if the user is new):**
1. Create a Claude Project called "Leader Review" (or similar).
2. Add this skill to the Project.
3. Upload `leaders.json` to the Project's Knowledge.
4. Open every new chat from inside that Project — the file is then automatically in scope.
5. After any update, save the new `leaders.json` Claude outputs back into Project Knowledge (replacing the old one).

**Always look for `leaders.json` first** before asking the user for leader info. Check:
1. Files attached to this turn (`/mnt/user-data/uploads/`)
2. Project knowledge / earlier in the conversation
3. Anything pasted as a code block

If you can't find it, ask the user where it is, or offer to bootstrap a new one using `assets/leaders_template.json`.

The schema is documented in `references/schema.md`. Read it before any Manage or Log operation.

## Mode: Review

This is the heart of the skill. The user has produced something — a doc, a plan, an email draft, a deck outline, a Slack message — and wants to know how their leader(s) would react.

### Step 1: Identify the reviewer(s)

- If the user named a leader, use that one.
- If they said "my leader" or "leadership" without naming, **proactively scan the user's content and propose the most-relevant leader(s)** based on the topic, then confirm. Don't ask "which leader?" cold — make a recommendation. E.g., "This is a hiring proposal — Sarah (your direct manager) is the obvious first reader, and David (skip-level VP) will be the approver if it goes up. Want both?"
- The user may want a **review chain** — multiple leaders in the order the doc would actually travel. This is often more valuable than a single review because problems compound up the chain. Default to suggesting a chain when the doc looks like something that would escalate (proposals, plans, asks for budget/headcount/scope changes, anything cross-functional). Single review is fine for status updates, 1:1 prep, and informal docs.
- The user may also want **adversarial reviews from leaders who'd disagree** — useful before walking into a contested meeting. If the user has logged tension or differing priorities between two leaders, offer this proactively: "Want me to also run this through Mark? You logged that he and Sarah disagreed on the pricing approach last quarter — worth seeing where he'd push back."

### Step 2: Load the profile fully

Before writing anything, internalize the leader's profile from `leaders.json`:
- Role, seniority, scope
- Personality traits and communication style
- What they care about (priorities, KPIs, success metrics)
- What annoys / triggers them (red flags, pet peeves, "instant no" patterns)
- Decision-making style (data-driven? gut? consensus? speed?)
- Recent interactions and quotes — these are the highest-signal source. A real quote beats a generic trait.
- Recurring feedback patterns from past reviews

The recent interactions log matters more than abstract traits. If the leader has said "I hate it when people bury the ask" three times in the last quarter, that should drive the review more than a personality adjective.

### Step 3: Produce the review

Before writing, read `references/review_craft.md`. It explains how to avoid the typical failure modes (sycophancy, generic-MBA-voice, hedge mush) and how to calibrate the leader's voice to match their actual register.

Default output structure (adjust if user asked for something specific):

```
## [Leader Name] reviewing: [doc title / topic]

**Gut reaction (first 30 seconds of reading):**
[One paragraph. What does this leader feel and think on first scan? Where do their eyes go? What do they skim past? This is the "hallway test" — would they get the point in 30 seconds?]

**Score: X/10** — [one-line justification, in the leader's voice/style]
- Clarity of ask: X/10
- Evidence / rigor: X/10
- Strategic fit (with their priorities): X/10
- Risk awareness: X/10
- Narrative & flow: X/10

**Inline annotations:**
[Walk through the doc section by section, or paragraph by paragraph for shorter pieces. For each chunk, quote a snippet (one sentence is enough) and write the leader's margin comment on it. This is the most important part — it's where generic feedback gets exposed. If a section would draw no reaction from this leader, say so and skip it; don't manufacture reactions. Aim for 4-10 annotations depending on doc length.]

> "[snippet from user's doc]"
> — [margin comment in leader's voice. Could be praise, a question, a flag, an eye-roll. Specific to this leader.]

**What works (from their lens):**
- [Specific things this specific leader would appreciate, given their priorities. Not generic praise.]

**What lands wrong:**
- [Specific things that would trip *this* leader's wires. Reference their known triggers / past feedback when possible.]

**Questions they'd ask you (the soul-searching ones):**
- [3-7 sharp questions the leader would actually fire back. These should feel like that leader — terse if they're terse, Socratic if they're Socratic, numbers-focused if they're a numbers person. Pull from their recent-interactions log for tone calibration. The bar: each question should make the user pause, not nod.]

**What you should change before sending (prioritized):**
1. [Highest-leverage change first — the one fix that most improves the leader's read]
2. [Next]
3. ...

**If you don't change anything, here's what likely happens:**
[Honest prediction. "They'll approve but with reservations." / "They'll send it back asking for X." / "They'll forward it to Y and you'll lose control of the narrative." / "They'll approve and you'll quietly lose trust capital you didn't know you spent."]

**Confidence note:**
[One line on how grounded this review is. "High confidence — this matches her last 3 logged reactions to similar pricing docs." OR "Medium — extrapolating from her general decision style; not many logged interactions on technical specs." OR "Low — profile is sparse on this topic, treat this review as a generic-VP draft."]
```

**No section is optional.** If a section truly doesn't apply, write one line saying why ("Score subscores not meaningful here — this is a 1-page status update, not a proposal") rather than skipping silently. Skipping creates the illusion of completeness; explicit nulls preserve honesty.

### Step 4: Stay in character, but flag uncertainty

Speak *as* the leader where it makes the review vivid (especially in the "Questions they'd ask"). But when the profile is thin or the situation is outside what you have data on, say so honestly: "I'm extrapolating here — you don't have many logged interactions about budget topics, so this is partly generic VP-of-Finance behavior."

Never invent quotes and attribute them to the leader. You can write *in their style* but make it clear it's a simulation.

### Multi-leader review chains

When the user wants several leaders in sequence, do them in the order the doc would actually travel (usually: direct manager → skip → cross-functional → exec). After each, briefly note: "If this passes [Name], the next concern shifts to..." — because each layer has different priorities, and the doc usually needs to evolve to survive the chain.

## Mode: Log

The user is feeding the system new information. This is what makes the skill get sharper over time.

### What to log

- **Interactions**: meetings, 1:1s, Slack threads, doc comments. Capture what was said, the user's interpretation, and the takeaway.
- **Past reviews**: "Mark rejected my pricing proposal last month — here's why."
- **Quotes**: verbatim things the leader said, especially memorable or repeated ones. These are gold for tone calibration later.
- **Profile updates**: role change, new priorities, new boss above them, observed mood shifts.

### How to log

1. Read existing `leaders.json`. (If missing, offer to create one.)
2. Identify which leader this is about.
3. Write the new entry into the right section of that leader's profile (`recent_interactions`, `quotes`, `feedback_patterns`, or update top-level fields like `current_priorities`).
4. **Also extract patterns**: if this interaction reinforces or contradicts an existing trait, update the trait. E.g., if the user logs "Sarah got annoyed I didn't have data" for the third time, promote "data-driven" higher in her decision style and add "no-data proposals" to her red flags if it isn't there.
5. Output the updated `leaders.json` as a code block for the user to save back.

Keep `recent_interactions` capped at ~20 entries per leader (rolling window — drop oldest). Older interactions that revealed lasting patterns should already be encoded in the abstract traits, so dropping the raw entry doesn't lose signal.

### Always echo what changed

After updating, tell the user concretely what changed and why. Not "Profile updated." Instead: "Added a quote to Sarah's profile, and bumped 'wants numerical evidence' from a trait to a top-3 priority — that's the 4th time you've logged her pushing back on something for lack of data."

## Mode: Manage

Setup, inspection, editing.

### Bootstrapping a new user

If the user has nothing yet:
1. Show them `assets/leaders_template.json` so they understand the shape.
2. Offer two paths: (a) interview them — ask about their leaders one at a time, building up profiles through conversation; or (b) let them fill the template themselves and paste it back.
3. Recommend (a) for users who don't want to think about JSON. Recommend (b) for users who already have notes on their leaders.

### Interview flow (for path a)

For each leader, ask in this order — but keep it conversational, not a checklist interrogation:
1. Name and role (and how senior — your direct manager? skip-level? a peer leader you need to influence?)
2. What do they obviously care about? What's on their OKRs / what gets them excited in meetings?
3. What annoys them? What's gotten you (or others) into trouble with them?
4. How do they make decisions? Fast or deliberate? Data or gut? Consensus or decree?
5. Communication style — terse or expansive? Formal or casual? Written or verbal?
6. Any verbatim quotes you remember? Things they say a lot?
7. What's your relationship like — do they trust you? Are you new? On thin ice?

Don't push for all of this in one go if the user is impatient. Even a 30%-filled profile is useful — you can flag uncertainty during reviews and the profile will fill in over time via the Log mode.

### Inspection

When the user asks "what do we have on [Name]" — show the profile in a readable format (not raw JSON), grouped logically. Highlight which fields are well-populated vs sparse. Suggest what's worth filling in.

### Editing

Make targeted changes and output the updated `leaders.json`. Don't rewrite the whole file when one field changes.

## Output rules

- When you produce an updated `leaders.json`, always show it as a complete JSON code block so the user can copy-paste back into their Project. Don't truncate.
- For reviews, default to markdown prose, not JSON.
- Never store actual personal data the user hasn't given you. Don't infer the leader's mental health, family situation, or anything sensitive from sparse info.
- This is a tool for the user's professional reflection — not a tool for manipulation. If the user starts asking things like "how do I psychologically exploit my boss's insecurity", redirect to constructive framings (how to communicate effectively given their style).

## Privacy reminder

The leader profiles contain candid characterizations of real people. Treat the data accordingly: don't paste it into other contexts, don't summarize it into chat history more than needed, and gently remind the user once per session that this file is sensitive if they seem to be sharing it broadly.
