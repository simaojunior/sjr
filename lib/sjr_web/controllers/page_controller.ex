defmodule SjrWeb.PageController do
  use SjrWeb, :controller

  alias Sjr.Blog

  def home(conn, _params) do
    locale = conn.assigns.locale

    render(conn, :home,
      posts: Blog.recent_posts(locale, 5),
      draft_posts: Blog.draft_posts(locale),
      total_posts: length(Blog.scroll_posts(locale))
    )
  end

  def til(conn, _params) do
    render(conn, :til, posts: Blog.posts_by_tag("til", conn.assigns.locale), page_title: "TIL")
  end

  def uses(conn, _params) do
    render(conn, :uses, page_title: "Uses")
  end
end
