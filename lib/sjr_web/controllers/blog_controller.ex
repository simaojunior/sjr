defmodule SjrWeb.BlogController do
  use SjrWeb, :controller

  alias Sjr.Blog

  def show(conn, %{"id" => id}) do
    if post = Blog.find_by_id(id) do
      render(conn, :show, post: post, page_title: post.title)
    else
      conn
      |> put_status(404)
      |> put_view(html: SjrWeb.ErrorHTML)
      |> render("404.html")
    end
  end
end
