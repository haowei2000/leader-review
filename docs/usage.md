# Usage

The skill operates in three modes. You don't pick the mode explicitly — it's inferred from how you phrase the request.

## Mode 1: Review

You have a piece of work and want to know how a leader would react.

### Single-leader review

> "Have Sarah review this Q3 proposal."
>
> "What would my manager think of this email draft?"
>
> "Score this deck from David's perspective."

You'll get: gut reaction, scored subdimensions, inline annotations on specific snippets, what works, what lands wrong, the questions they'd ask, prioritized changes, predicted outcome, and a confidence note.

### Review chain

> "Run this through Sarah, then David, then the CEO."
>
> "Pre-mortem this proposal — assume it goes up the full chain."

The skill reviews in escalation order and notes how the doc needs to evolve to survive each layer. Each leader has different priorities, so a doc that passes the first reader may stumble at the second.

### Adversarial review

If you've logged that two leaders disagreed on something, the skill will sometimes proactively suggest running the doc through both:

> "Want me to also have Mark look at this? You logged that he and Sarah disagreed on the pricing approach last quarter."

You can also request this directly:

> "Have Sarah and Mark both review this — show me where they'd disagree."

## Mode 2: Log

This is what makes the skill get smarter over time. Whenever something happens with a leader, log it.

### Logging an interaction

> "My manager said in our 1:1 today that she's frustrated I keep starting docs without a clear ask. Log that."
>
> "David rejected the launch plan. He said the timing was wrong because we don't have the support story figured out. Log it under his profile."

The skill will:

1. Add the interaction to the leader's `recent_interactions` log
2. Check whether this reinforces an existing pattern (e.g., third time you've logged "no clear ask" feedback) and update the abstract traits accordingly
3. Output the updated `leaders.json` for you to save back

### Logging a quote

> "Quote from Sarah today: 'Tell me what changed, not what you did.' Save it."

Quotes are higher-signal than abstract traits because they preserve the actual register and cadence of the leader. Save the memorable ones.

### Updating profile fields

> "Sarah just got promoted to VP. Update her profile."
>
> "Add to David's priorities: he just told me the board is pushing for international expansion."

## Mode 3: Manage

Setup, inspection, and editing.

### Bootstrap a new leader

> "I just got a new skip-level. Help me build her profile."

The skill will interview you — name, role, what they care about, what annoys them, decision style, communication preferences, any quotes you remember. You don't have to answer every question; sparse profiles are fine to start.

### Inspect a leader

> "Show me what we have on Sarah."
>
> "What's in David's red flags list?"

You'll get a readable summary (not raw JSON), with hints about which fields are well-populated vs sparse and what's worth filling in.

### Edit

> "Move 'data-driven' from Sarah's traits to her decision style."
>
> "Remove the quote from January — that wasn't her, I misremembered."

## Tips

**Log fast and small.** A 1-line note right after a meeting is more useful than a polished retrospective a week later. The skill does the synthesis; you just need the raw observation.

**Quotes > traits.** "She said 'I don't read menus'" beats "she's decisive." When in doubt, log the words.

**Trust your gut on your own leader.** If a simulated review feels off, say so. The skill will update the profile based on your correction, not double down on its initial read.

**Don't over-fill at setup.** It's tempting to spend an hour writing a perfect profile. Don't. Start with 5 minutes, then let real interactions populate the profile organically through Log mode.

**Re-run reviews after edits.** If you update a doc based on a review, run it again. Often the *new* version surfaces a different set of objections — that's what the real reader would have done too.
