%{
  draft: true,
  featured: true,
  title: "Cutting deploy time from 5 minutes to 1",
  author: "Simão Júnior",
  tags: ["career", "devops", "ci-cd"],
  rank: "A-rank",
  icon: "rocket",
  description: "Building a CI/CD pipeline with GitHub Actions, Docker, and Azure Container Registry that turned deploys from a coffee break into a non-event."
}
---
Every deploy meant about five minutes of watching a terminal, and most of
that time went to manual steps that had to happen before the build even
started. Nobody scheduled a deploy for a slow afternoon on purpose, but
that is effectively what everyone did.

The goal was to get deploys to the point where a developer could kick one
off and move on to something else, instead of treating it as an event that
needed a clear calendar slot.

I rebuilt the pipeline on GitHub Actions with Docker layer caching and
pushed images through Azure Container Registry. The point was not to make
the existing manual steps faster, it was to remove them, so the pipeline
did the checking and the building without anyone standing over it.

Deploys dropped to about a minute end to end. The bigger win was not the
saved four minutes, it was that nobody had to remember to run the steps
that used to precede the build, because those steps no longer existed.
