# leaders.json schema

The single source of truth for the leader-review skill. The user maintains this file themselves (Project knowledge / chat upload / paste).

## Top-level structure

```json
{
  "version": 1,
  "owner": "user's name or handle (optional)",
  "last_updated": "YYYY-MM-DD",
  "leaders": [
    { ...leader object... },
    { ...leader object... }
  ]
}
```

## Leader object

Every field is optional except `name` and `role`. Sparse profiles are fine — flag uncertainty during reviews, fill in over time.

```json
{
  "id": "short-stable-handle, e.g. 'sarah-vp-product'",
  "name": "Sarah Chen",
  "role": "VP of Product",
  "relationship": "skip-level | direct-manager | cross-functional-peer | dotted-line | board",
  "seniority_distance": "how many levels above the user (0 = peer, 1 = direct manager, 2 = skip, etc.)",

  "personality": {
    "traits": ["analytical", "blunt", "impatient with hand-waving"],
    "communication_style": "terse, prefers written over verbal, allergic to long preambles",
    "energy": "high-intensity / measured / variable"
  },

  "decision_style": {
    "speed": "fast | deliberate | depends",
    "evidence": "data-driven | gut | mixed",
    "process": "decisive | consensus-seeking | delegating",
    "notes": "free-form, e.g. 'will push back hard once, then defer if you hold your ground'"
  },

  "current_priorities": [
    "Q4 revenue target",
    "shipping the enterprise tier",
    "getting headcount approved"
  ],

  "what_they_appreciate": [
    "TL;DR at the top",
    "owning the ask explicitly",
    "showing tradeoffs not just the chosen path"
  ],

  "red_flags": [
    "burying the ask",
    "unclear ownership",
    "proposals without numbers",
    "'we need to think about' — wants concrete next steps"
  ],

  "quotes": [
    { "date": "2026-03-12", "context": "review of pricing memo", "text": "If you can't put a number on it, you don't understand it yet." },
    { "date": "2026-02-04", "context": "1:1", "text": "Stop telling me what's hard. Tell me what you're doing about it." }
  ],

  "feedback_patterns": [
    "consistently asks for the cost of inaction",
    "rejects proposals that don't name the tradeoff",
    "warms up when shown competitor benchmarks"
  ],

  "recent_interactions": [
    {
      "date": "2026-04-20",
      "type": "1:1 | doc review | meeting | slack | email | hallway",
      "topic": "Q3 retention plan",
      "what_happened": "I walked her through the proposal. She agreed with the diagnosis but pushed back on the activation experiment — wanted to see the prior data before committing engineers.",
      "user_takeaway": "Need historical numbers next time. She doesn't trust new experiments without baseline."
    }
  ],

  "relationship_state": {
    "trust_level": "low | building | solid | high",
    "current_standing": "free-form, e.g. 'recovering from the missed launch — being extra careful with commits'",
    "notes": "anything else worth knowing about how the user should currently approach them"
  }
}
```

## Field guidance

**`quotes` vs `feedback_patterns`**: Quotes are verbatim. Patterns are abstractions across multiple interactions. When you log the third quote saying roughly the same thing, also add a pattern.

**`recent_interactions` vs `feedback_patterns`**: Interactions are events. Patterns are what those events teach you. Recent interactions decay — drop oldest after ~20. Patterns persist.

**`red_flags` vs `what_they_appreciate`**: Frame both behaviorally, not as character judgments. "Burying the ask" is actionable. "Sarah is impatient" isn't.

**`relationship_state`**: This affects review tone. A leader who currently distrusts the user will review the same doc more harshly. The simulator should reflect that.

## Migration / versioning

Bump `version` if the schema ever changes. Old files should still load — be tolerant of missing fields.
