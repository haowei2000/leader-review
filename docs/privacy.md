# Privacy & data handling

Your `leaders.json` is sensitive. It contains candid, often unflattering, characterizations of real people — your managers, peers, and execs. Treat it like a private journal.

## Where the data lives

- **In your Claude Project's Knowledge**, if you set it up that way (recommended).
- **On your local machine**, if you keep it there and paste it into chats as needed.
- **Inside the conversation context**, while you're chatting.

The skill itself has **no server-side storage** for your data. It reads `leaders.json` from whatever's in scope (Project Knowledge, attachment, pasted text), produces an updated version when you log new info, and hands it back to you. Anything that doesn't make it back into your saved file is gone after the session.

## What you should not do

- **Don't commit your real `leaders.json` to a public repo.** This repo's `.gitignore` excludes the filename pattern by default — but if you rename your file to something else, double-check it's not tracked.
- **Don't paste it into chats outside your private Project.** It's easy to share a leader profile by accident when sharing a chat link.
- **Don't include passwords, contact info, salary, or anything HR-confidential.** The schema isn't designed for that, and the skill has no special handling for it.
- **Don't share `leaders.json` with the people it describes.** This is your working notes for navigating professional relationships, not a peer-review document.

## What the skill won't do

- The skill will not help you "psychologically exploit" a leader, manipulate someone's insecurities, or craft messages designed to deceive. If you ask, it'll redirect to constructive framings (how to communicate effectively given a leader's known style).
- The skill will not infer sensitive attributes (mental health, family situation, political views, etc.) from sparse data and write them into the profile.
- The skill will not produce a review that's primarily an attack on the leader as a person. The job is to pressure-test your work using their lens, not to assemble a dossier.

## If you stop using the skill

Delete `leaders.json` from your Project Knowledge (and any local copies). The skill has no other store of the data — once your file is gone, it's gone.

## What about Anthropic's data handling?

Anything you send to Claude is subject to Anthropic's standard data and privacy policies, which apply to this skill the same way they apply to any other Claude conversation. The skill doesn't change those defaults; see Anthropic's [privacy policy](https://www.anthropic.com/legal/privacy) for current terms.

## Suggestion: redact when in doubt

If you're nervous about logging something — say, a leader's behavior in a sensitive moment — write it more abstractly. Instead of the verbatim quote, log the pattern. Instead of names, use roles. The skill works fine with abstracted profiles. The closer-to-verbatim data does produce sharper simulations, but it's a tradeoff you control.
