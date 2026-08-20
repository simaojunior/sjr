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

  describe "open graph metadata" do
    test "a published post describes itself", %{conn: conn} do
      conn = get(conn, ~p"/posts/inspect-package-json-scripts")
      html = html_response(conn, 200)

      assert html =~ ~s(property="og:type" content="article")
      assert html =~ ~s(property="og:title" content="Quickly Inspect package.json Scripts")
      assert html =~ ~s(property="og:description" content="A quick way to check)
      assert html =~ ~s(property="article:published_time" content="2026-06-28")
      assert html =~ ~s(property="article:tag" content="til")
      assert html =~ "/posts/inspect-package-json-scripts"
    end

    test "a page without post assigns keeps the site defaults", %{conn: conn} do
      conn = get(conn, ~p"/")
      html = html_response(conn, 200)

      assert html =~ ~s(property="og:type" content="website")
      assert html =~ ~s(property="og:title" content="Simão Júnior · simaojunior.dev")
      refute html =~ "article:published_time"
    end
  end

  describe "draft visibility" do
    test "a draft stays reachable so it can be shared for review", %{conn: conn} do
      conn = get(conn, ~p"/posts/hello-world")

      assert html_response(conn, 200) =~ "Hello, world"
    end

    test "a draft is marked noindex", %{conn: conn} do
      conn = get(conn, ~p"/posts/hello-world")

      assert html_response(conn, 200) =~ ~s(name="robots" content="noindex, nofollow")
    end

    test "a published post is indexable", %{conn: conn} do
      conn = get(conn, ~p"/posts/inspect-package-json-scripts")

      refute html_response(conn, 200) =~ ~s(name="robots")
    end

    test "a page without post assigns is indexable", %{conn: conn} do
      conn = get(conn, ~p"/")

      refute html_response(conn, 200) =~ ~s(name="robots")
    end
  end
end
