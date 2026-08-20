defmodule SjrWeb.ErrorHTMLTest do
  use SjrWeb.ConnCase, async: true

  # Bring render_to_string/4 for testing custom views
  import Phoenix.Template, only: [render_to_string: 4]

  test "renders 404.html" do
    html = render_to_string(SjrWeb.ErrorHTML, "404", "html", [])

    assert html =~ "MISSION FAILED · 404"
    assert html =~ "This scroll was never filed."
    assert html =~ ~s(href="/")
  end

  test "renders 500.html" do
    assert render_to_string(SjrWeb.ErrorHTML, "500", "html", []) == "Internal Server Error"
  end
end
