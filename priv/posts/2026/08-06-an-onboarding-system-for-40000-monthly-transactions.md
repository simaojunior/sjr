%{
  title: "An onboarding system for 40,000 monthly transactions",
  author: "Simão Júnior",
  tags: ["career", "architecture"],
  rank: "S-rank",
  description: "Facial biometrics, OCR, and CPF validation, processing roughly 15 transactions per second in production."
}
---
I built an onboarding flow combining facial biometrics, OCR, and CPF
(taxpayer ID) validation, integrated with Serpro and Receita Federal. It
processes over 40,000 monthly transactions at around 15 TPS.

The interesting part wasn't the throughput. It was reducing fraud and
chargebacks with a biometric-based risk scoring system while keeping
approval rates up, which meant every change had to be measured against both
sides at once.
