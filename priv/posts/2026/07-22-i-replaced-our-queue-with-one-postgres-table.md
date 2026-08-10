%{
  title: "I replaced our queue with one Postgres table",
  author: "Simão Júnior",
  tags: ["placeholder"],
  rank: "S-rank",
  icon: "queue",
  description: "SKIP LOCKED, a status column, and 300 lines. Six months in production: what broke and what didn't."
}
---
> Placeholder post carried over from the homepage design mock. Replace with a
> real write-up when ready.

The job queue was a managed service with its own bill, its own outage
history, and a dashboard that nobody on the team fully understood, myself
included on a bad day.

Replacing it meant finding something the team could actually operate,
without giving up the guarantees that had justified the original choice in
the first place.

I built the replacement on a single Postgres table, using `SELECT ...
FOR UPDATE SKIP LOCKED` for concurrency and a status column instead of a
separate state store, so there was one system of record instead of two.

Six months in production, it has handled the same load in about 300 lines
of code, and the failures it has had were ones the team could actually
read a stack trace and debug.
