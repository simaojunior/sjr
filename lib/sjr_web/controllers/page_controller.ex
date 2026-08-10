defmodule SjrWeb.PageController do
  use SjrWeb, :controller

  alias Sjr.Blog

  def home(conn, _params) do
    render(conn, :home,
      posts: Blog.recent_posts(5),
      draft_posts: Blog.draft_posts(),
      total_posts: length(Blog.scroll_posts())
    )
  end

  def til(conn, _params) do
    render(conn, :til, posts: Blog.posts_by_tag("til"), page_title: "TIL")
  end

  def uses(conn, _params) do
    render(conn, :uses, page_title: "Uses")
  end
end
