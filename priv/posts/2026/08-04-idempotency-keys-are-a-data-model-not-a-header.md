%{
  draft: true,
  featured: true,
  title: "Idempotency keys are a data model, not a header",
  author: "Simão Júnior",
  tags: [],
  rank: "A-rank",
  icon: "key",
  description: "Every retry bug I've debugged came down to storing the wrong thing. What to persist, and when."
}
---
![Idempotency keys are a data model, not a header](/images/posts/idempotency-keys-are-a-data-model-not-a-header.jpg)

> Placeholder post carried over from the homepage design mock. Replace with a
> real write-up when ready; the title, rank, and teaser above are already
> wired into the mission log on the homepage.

A payment retry landed twice in production. The idempotency key that was
supposed to prevent it turned out to live in a request header, which meant
it vanished the moment the client retried with a slightly different one.

The question was what actually needed to persist to make a retry safe,
rather than patching the one check that happened to cover the bug report
in front of us.

I moved the key off the transport layer entirely and modeled it as a
record tied to the operation it protected, with its own lifecycle and
expiry, instead of trusting whatever the client happened to send along.

Retries stopped duplicating, and the fix generalized to every endpoint
that touched money, not just the one that had broken.
