%{
  title: "Cutting deploy time from 5 minutes to 1",
  author: "Simão Júnior",
  tags: ["career", "devops", "ci-cd"],
  rank: "A-rank",
  icon: "rocket",
  description: "Building a CI/CD pipeline with GitHub Actions, Docker, and Azure Container Registry that turned deploys from a coffee break into a non-event."
}
---
Every deploy used to take about 5 minutes end to end: build, push, restart,
cross fingers. Most of that time was wasted work, not real work.

I rebuilt the pipeline around GitHub Actions, Docker layer caching, and Azure
Container Registry. Deploys dropped to about a minute, and the manual steps
that used to precede them disappeared entirely.
