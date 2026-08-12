defmodule SjrWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use SjrWeb, :html

  embed_templates "page_html/*"

  def last_updated_label, do: Calendar.strftime(Date.utc_today(), "%-d %b %Y")

  def cv_path("pt-br"), do: ~p"/files/simao-junior-cv-pt-br.pdf"
  def cv_path(_locale), do: ~p"/files/simao-junior-cv-en.pdf"

  def ticker_text do
    nbsp = " "

    gettext(
      "✧ status: shipping day to day %{nbsp}·%{nbsp} ✧ training: Elixir, OTP supervision trees %{nbsp}·%{nbsp} ✧ site running on Phoenix + Fly.io %{nbsp}·%{nbsp} ✧ rewatching Shippuden, arc 14 %{nbsp}·%{nbsp} ✧ last updated %{date} %{nbsp}·%{nbsp}%{nbsp}",
      nbsp: nbsp,
      date: last_updated_label()
    )
  end
end
