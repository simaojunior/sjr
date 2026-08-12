%{
  draft: true,
  title: "An onboarding system for 40,000 monthly transactions",
  author: "Simão Júnior",
  tags: ["career", "architecture"],
  rank: "S-rank",
  icon: "fingerprint",
  description: "Facial biometrics, OCR, and CPF validation, processing roughly 15 transactions per second in production."
}
---
![An onboarding system for 40,000 monthly transactions](/images/posts/an-onboarding-system-for-40000-monthly-transactions.jpg)

Onboarding was the first thing every new user hit at Nextcode, and it
depended on manual document review. That held up fine at a few thousand
signups a month. It did not hold up as volume grew toward tens of
thousands, and the review queue started dictating how fast the business
could actually grow.

The goal was an automated onboarding flow that verified identity fast
enough not to lose users mid-signup, while catching the fraud that manual
review had mostly been catching by accident rather than by design.

I built a pipeline combining facial biometrics, OCR extraction, and CPF
(taxpayer ID) validation, wired into Serpro and Receita Federal for real
government-side verification instead of a client-supplied claim. On top of
that I layered a biometric-based risk scoring model, so borderline cases
got flagged for a second look instead of being auto-approved or
auto-rejected outright.

The system now processes over 40,000 transactions a month at roughly 15
per second in production. Fraud and chargebacks went down while approval
rates went up, two numbers that had been trading off against each other
under the old manual process.
