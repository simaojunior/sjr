%{
  draft: true,
  title: "Shadow reads: migrating a monolith nobody wrote down",
  author: "Simão Júnior",
  tags: [],
  rank: "S-rank",
  icon: "layers",
  description: "How we moved 40 endpoints off a PHP service without one planned downtime window."
}
---
![Shadow reads: migrating a monolith nobody wrote down](/images/posts/shadow-reads-migrating-a-monolith-nobody-wrote-down.jpg)

> Placeholder post carried over from the homepage design mock. Replace with a
> real write-up when ready.

Forty endpoints were still running on a PHP monolith older than anyone
currently on the team, with no documentation explaining what half of it
actually did or why.

Migrating that traffic to the new service meant doing it without a
maintenance window, since the business had no appetite for planned
downtime and even less appetite for an unplanned one.

I ran both systems in parallel, shadowing reads from the old service
against the new one and comparing responses before cutting any real
traffic over, endpoint by endpoint.

All 40 endpoints moved without a single planned downtime window, and the
shadow reads caught several behavior mismatches that would otherwise have
become production incidents after the cutover.
