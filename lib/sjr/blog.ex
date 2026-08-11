defmodule Sjr.Blog do
  @moduledoc """
  The Blog context for managing blog posts.

  Uses NimblePublisher to parse and serve markdown blog posts from the
  priv/posts directory. No database — posts are compiled at build time.
  """

  use NimblePublisher,
    build: Sjr.Blog.Post,
    from: Application.app_dir(:sjr, "priv/posts/**/*.md"),
    as: :posts,
    html_converter: Sjr.Blog.MarkdownConverter,
    parser: Sjr.Blog.Parser

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  @tags @posts
        |> Enum.flat_map(& &1.tags)
        |> Enum.uniq()
        |> Enum.sort()

  def all_posts, do: @posts
  def all_tags, do: @tags

  @doc "Posts visible on the home page and /scrolls listing, drafts excluded."
  def published_posts, do: Enum.reject(all_posts(), & &1.draft)

  @doc "Published long-form posts for the mission log; til posts live on /til instead."
  def scroll_posts(locale \\ "en") do
    published_posts()
    |> Enum.reject(&("til" in &1.tags))
    |> Enum.filter(&(&1.locale == locale))
  end

  @doc "Featured draft posts, shown as coming-soon placeholders on the home page."
  def draft_posts(locale \\ "en") do
    Enum.filter(all_posts(), &(&1.draft && &1.featured && &1.locale == locale))
  end

  def posts_by_tag(tag, locale \\ "en") do
    Enum.filter(published_posts(), fn post -> tag in post.tags and post.locale == locale end)
  end

  @doc "Finds a post by id regardless of draft or locale, so preview links still work."
  def find_by_id(id) do
    Enum.find(all_posts(), fn post -> post.id == id end)
  end

  @doc """
  Finds the sibling translation of a post via its `translation_key`,
  used to cross-link an EN post to its PT-BR counterpart and back.
  """
  def find_translation(%Sjr.Blog.Post{translation_key: nil}), do: nil

  def find_translation(%Sjr.Blog.Post{translation_key: key, locale: locale}) do
    Enum.find(published_posts(), &(&1.translation_key == key && &1.locale != locale))
  end

  @doc "Label for a link pointing at `translation`, in the language it's written in."
  def translation_link_label(%Sjr.Blog.Post{locale: "pt-br"}), do: "🇧🇷 Ler em português"
  def translation_link_label(%Sjr.Blog.Post{locale: _}), do: "🇺🇸 Read in English"

  def recent_posts(locale \\ "en", limit \\ 4), do: Enum.take(scroll_posts(locale), limit)

  @words_per_minute 200

  @doc "Estimated reading time in minutes, from the post's plaintext word count."
  def reading_time_minutes(%Sjr.Blog.Post{text_content: text}) do
    words = String.split(text, ~r/\s+/, trim: true)
    max(1, div(length(words), @words_per_minute))
  end

  @doc """
  A mission-log "rank" label for the post. Honors an explicit `rank` in
  frontmatter; otherwise derives one from estimated reading time.
  """
  def rank(%Sjr.Blog.Post{rank: rank}) when is_binary(rank), do: rank

  def rank(%Sjr.Blog.Post{} = post) do
    case reading_time_minutes(post) do
      minutes when minutes >= 11 -> "S-rank"
      minutes when minutes >= 8 -> "A-rank"
      minutes when minutes >= 5 -> "B-rank"
      _ -> "C-rank"
    end
  end
end
