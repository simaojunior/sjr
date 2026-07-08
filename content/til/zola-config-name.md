+++
title = "Zola reads both config.toml and zola.toml"
date = 2026-07-07
description = "Zola looks for either config.toml or zola.toml at the project root."

[taxonomies]
tags = ["zola"]
+++

Zola looks for its configuration at the project root under **either**
`config.toml` **or** `zola.toml` — no `-c` flag needed. Pass `-c <path>` only
when the file lives elsewhere or has a different name.
