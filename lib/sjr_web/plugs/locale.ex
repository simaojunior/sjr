defmodule SjrWeb.Plugs.Locale do
  @moduledoc """
  Assigns the visitor's locale to the conn: an explicit cookie choice wins,
  otherwise it's derived from the Accept-Language header. Defaults to "en".
  """
  @behaviour Plug

  import Plug.Conn

  @supported ["en", "pt-br"]
  @cookie "sj-locale"

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    conn = fetch_cookies(conn)
    locale = conn.req_cookies[@cookie] || locale_from_header(conn)
    locale = if locale in @supported, do: locale, else: "en"

    Gettext.put_locale(SjrWeb.Gettext, gettext_locale(locale))

    assign(conn, :locale, locale)
  end

  defp gettext_locale("pt-br"), do: "pt_BR"
  defp gettext_locale(locale), do: locale

  defp locale_from_header(conn) do
    case get_req_header(conn, "accept-language") do
      [header | _] -> header |> String.split(",") |> List.first() |> parse_tag()
      [] -> "en"
    end
  end

  defp parse_tag(tag) do
    tag
    |> String.trim()
    |> String.split(";")
    |> List.first()
    |> String.downcase()
    |> then(&if String.starts_with?(&1, "pt"), do: "pt-br", else: "en")
  end
end
