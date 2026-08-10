defmodule SjrWeb.PageController do
  use SjrWeb, :controller

  alias Sjr.Blog

  def home(conn, _params) do
    render(conn, :home,
      posts: Blog.recent_posts(4),
      total_posts: length(Blog.all_posts())
    )
  end
end
