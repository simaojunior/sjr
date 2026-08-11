%{
  draft: true,
  featured: true,
  locale: "pt-br",
  translation_key: "cutting-deploy-time",
  title: "Cortando o tempo de deploy de 5 minutos para 1",
  author: "Simão Júnior",
  tags: ["career", "devops", "ci-cd"],
  rank: "A-rank",
  icon: "rocket",
  description: "Construindo um pipeline de CI/CD com GitHub Actions, Docker e Azure Container Registry que transformou deploys de uma pausa para o café em um não-evento."
}
---
Todo deploy significava cerca de cinco minutos olhando para um terminal, e a
maior parte desse tempo ia para passos manuais que precisavam acontecer antes
mesmo do build começar. Ninguém agendava um deploy para uma tarde tranquila de
propósito, mas era efetivamente isso que todo mundo fazia.

O objetivo era chegar ao ponto em que um desenvolvedor pudesse disparar um
deploy e seguir para outra coisa, em vez de tratá-lo como um evento que
precisava de um horário reservado na agenda.

Eu reconstruí o pipeline no GitHub Actions com cache de camadas do Docker e
enviei as imagens pelo Azure Container Registry. O ponto não era deixar os
passos manuais existentes mais rápidos, era removê-los, para que o pipeline
fizesse a checagem e o build sem ninguém precisando ficar de olho.

Os deploys caíram para cerca de um minuto do início ao fim. O maior ganho não
foram os quatro minutos economizados, foi que ninguém mais precisava lembrar
de rodar os passos que costumavam preceder o build, porque esses passos
simplesmente deixaram de existir.
