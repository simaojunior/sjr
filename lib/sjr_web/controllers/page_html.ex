defmodule SjrWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use SjrWeb, :html

  embed_templates "page_html/*"

  def last_updated_label, do: Calendar.strftime(Date.utc_today(), "%-d %b %Y")
  def current_year, do: Date.utc_today().year
end
