%{
  draft: false,
  title: "Quickly Inspect package.json Scripts",
  author: "Simão Júnior",
  tags: ["til", "fish", "nushell", "shell", "json"],
  description: "A quick way to check package.json scripts using a shell function."
}
---
![Quickly Inspect package.json Scripts](/images/posts/inspect-package-json-scripts.jpg)

Not exactly new knowledge, but today I felt like adding another small utility to
my shell toolkit: a quick way to list every script defined in a `package.json`
without scrolling past endless dependencies.

In [fish](https://fishshell.com/):

```fish
function package-scripts
    cat package.json | jq ".scripts"
end
```

[nushell](https://www.nushell.sh/) reads JSON natively, so there's no need for
`jq` at all:

```nu
def package-scripts [] {
    open package.json | get scripts
}
```

A swift way to review the available scripts without the hassle of opening the
whole file.
