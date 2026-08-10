defmodule SjrWeb.BlogControllerTest do
  use SjrWeb.ConnCase, async: true

  test "GET /posts/:id renders a known post", %{conn: conn} do
    conn = get(conn, ~p"/posts/hello-world")
    assert html_response(conn, 200) =~ "Hello, world"
  end

  test "GET /posts/:id 404s for an unknown post", %{conn: conn} do
    conn = get(conn, ~p"/posts/does-not-exist")
    assert conn.status == 404
  end
end
