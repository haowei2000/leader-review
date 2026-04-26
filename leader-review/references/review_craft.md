# Review Craft

How to make the simulated review actually useful — not generic, not sycophantic, not a costume.

## The core test

A good simulated review passes this test: **if the user showed it to someone who knows the leader, that person would say "yeah, that sounds like them."**

Generic management feedback fails this test. Anything that could apply to any VP-of-Anything fails this test.

## Use the profile, in order of priority

1. **Recent interactions and quotes** — highest signal. Real things this real person said. If a quote applies, channel it directly.
2. **Feedback patterns** — second highest. These are derived from multiple interactions; they're the user's hard-won pattern recognition.
3. **Red flags and priorities** — concrete, actionable.
4. **Personality and decision style** — useful for tone, but don't lean on these alone. "Analytical" is what you say when you don't know anything specific.

If the only thing in the profile is personality adjectives, the review will feel generic. Say so to the user — recommend logging more interactions.

## Voice calibration

Match the leader's actual register, not a generic "executive" voice.

- **Terse leader** → short questions, sentence fragments, no warm-up. "Pricing? Why this number?"
- **Socratic leader** → asks instead of asserts. "What happens if you're wrong about adoption?"
- **Numbers-first leader** → leads with quantitative concerns. "I count three claims here without numbers."
- **Story-first leader** → leads with the narrative arc. "Walk me through the customer's day."
- **Skeptical leader** → assumes the worst case. "Best case I get. What's the failure mode?"

Read their quotes and try to match the cadence.

## Avoid these failure modes

**Sycophancy.** "This is a strong proposal." Cut. Either say what's strong specifically, or don't say it.

**Feature-list praise.** "Good structure, clear writing, solid analysis." This is what bad managers say. Skip.

**Hedge mush.** "You might want to consider perhaps thinking about..." — unhelpful. Be direct in the leader's voice; a real leader doesn't hedge to their report.

**Generic MBA questions.** "What's the TAM? What's the moat?" — only ask these if the leader actually asks these. Otherwise it feels like a costume.

**Ignoring the relationship state.** A leader who currently distrusts the user reviews differently than one who doesn't. Reflect that. If `trust_level` is "low" or `current_standing` is rocky, the same doc gets read with more skepticism. If it's "high", small flaws get a pass.

## What to do when the profile is thin

Be honest. Two-tier the review:
- **High-confidence calls** (anchored in actual logged data) — labeled clearly.
- **Generic-leader extrapolation** (because the profile doesn't have data on this aspect) — labeled separately.

Then suggest what to log next: "If you can capture how she reacts to this, especially the timing question, it'll sharpen future reviews."

## Scoring guidance

A 10 is rare. A 7 means "fine, will land but unmemorable." A 5 means "they'll send it back." A 3 means "they'll lose trust if you submit this."

Don't grade-inflate. The whole point is to catch problems before the real review.

## When the user pushes back

If the user says "I don't think she'd say that" — listen. Their gut on their own leader is more accurate than the simulation. Update the profile based on what they tell you, then re-run the review.
