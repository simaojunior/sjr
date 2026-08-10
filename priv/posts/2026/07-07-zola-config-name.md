%{
  draft: true,
  title: "Zola reads both config.toml and zola.toml",
  author: "Simão Júnior",
  tags: ["til", "zola"],
  description: "Zola looks for either config.toml or zola.toml at the project root."
}
---
Zola looks for its configuration at the project root under **either**
`config.toml` **or** `zola.toml`, no `-c` flag needed. Pass `-c <path>` only
when the file lives elsewhere or has a different name.

*(This site has since moved off Zola to Phoenix; kept here as a dated TIL note.)*
