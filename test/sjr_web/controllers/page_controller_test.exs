defmodule SjrWeb.PageControllerTest do
  use SjrWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Mission log"
  end

  test "GET /uses", %{conn: conn} do
    conn = get(conn, ~p"/uses")
    assert html_response(conn, 200) =~ "Neovim"
  end
end
