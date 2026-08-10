defmodule SjrWeb.PageControllerTest do
  use SjrWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Mission log"
  end
end
