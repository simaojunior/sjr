# simaojunior.com

Personal website and blog. Static site built with [Zola](https://www.getzola.org/)
and the [zola-hacker](https://www.getzola.org/themes/zola-hacker/) theme.

## Development

The dev environment is a Nix flake (direnv auto-loads it via `.envrc`):

```sh
nix develop        # or `direnv allow` once, then it loads automatically
zola serve         # preview at http://127.0.0.1:1111
zola build         # output to ./public
```

## Deploy (Cloudflare Pages, direct upload)

`wrangler` is provided by the flake. Deploys upload the built `./public` directory
straight to a Cloudflare Pages project — no Git/CI required.

```sh
wrangler login                                       # one-time, opens a browser
zola build                                           # produce ./public
wrangler pages deploy public --project-name simaojunior
```

The first deploy creates the `simaojunior` project (choose `main` as the
production branch when prompted). After it's live on `*.pages.dev`, attach the
custom domain in the Cloudflare dashboard: **Workers & Pages → simaojunior →
Custom domains → Set up a domain → `simaojunior.com`**. A domain can only be on
one project, so remove it from the old project first (that project keeps serving
until you switch).

## Structure

- `config.toml` — site config: base URL, nav menu (Home / Writing / TIL), social links.
- `content/_index.md` — the Home landing page (bio + latest posts).
- `content/writing/` — long-form posts. New post: add `content/writing/<slug>.md`.
- `content/til/` — Today-I-Learned notes. New note: add `content/til/<slug>.md`.
- `templates/` — overrides layered on top of the theme:
  - `index.html` — Home layout (bio + recent Writing/TIL).
  - `section.html` — paginated list page for `/writing` and `/til` (theme ships none).
  - `partials/navigation.html` — nav without the theme's "View on GitHub" button.
  - `partials/footer.html` — copyright driven by `extra.copyright_start_year`.
- `data/socials.yml` — platform → URL/icon lookup used by the footer icons.
- `themes/hacker/` — the theme, pinned as a git submodule.

Clone with submodules: `git clone --recurse-submodules <url>` (or run
`git submodule update --init` after cloning).

## Writing a post

Front matter for a new post:

```toml
+++
title = "Post title"
date = 2025-07-07
description = "One-line summary for SEO and previews."

[taxonomies]
tags = ["example"]
+++

Intro paragraph shown in list summaries.
<!--more-->

Full body...
```
