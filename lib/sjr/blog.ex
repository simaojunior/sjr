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
  def scroll_posts, do: Enum.reject(published_posts(), &("til" in &1.tags))

  @doc "Featured draft posts, shown as coming-soon placeholders on the home page."
  def draft_posts, do: Enum.filter(all_posts(), &(&1.draft && &1.featured))

  def posts_by_tag(tag) do
    Enum.filter(published_posts(), fn post -> tag in post.tags end)
  end

  @doc "Finds a post by id regardless of draft status, so preview links still work."
  def find_by_id(id) do
    Enum.find(all_posts(), fn post -> post.id == id end)
  end

  def recent_posts(limit \\ 4), do: Enum.take(scroll_posts(), limit)

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
