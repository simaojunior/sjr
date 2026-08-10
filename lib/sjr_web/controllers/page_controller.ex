defmodule SjrWeb.PageController do
  use SjrWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
