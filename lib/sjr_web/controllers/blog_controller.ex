defmodule SjrWeb.BlogController do
  use SjrWeb, :controller

  alias Sjr.Blog

  def show(conn, %{"id" => id}) do
    if post = Blog.find_by_id(id) do
      render(conn, :show,
        post: post,
        page_title: post.title,
        og_title: post.title,
        og_description: post.description,
        og_url: url(~p"/posts/#{post.id}"),
        og_type: "article",
        og_published_time: Date.to_iso8601(post.date),
        og_tags: post.tags,
        noindex: post.draft
      )
    else
      conn
      |> put_status(404)
      |> put_view(html: SjrWeb.ErrorHTML)
      |> render("404.html")
    end
  end
end
