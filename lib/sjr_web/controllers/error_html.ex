defmodule SjrWeb.ErrorHTML do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on HTML requests.

  See config/config.exs.
  """
  use SjrWeb, :html

  # If you want to customize your error pages,
  # uncomment the embed_templates/1 call below
  # and add pages to the error directory:
  #
  #   * lib/sjr_web/controllers/error_html/404.html.heex
  #   * lib/sjr_web/controllers/error_html/500.html.heex
  #
  embed_templates "error_html/*"

  # Anything without its own template (500s and friends) falls back to the
  # plain status message, e.g. "Internal Server Error".
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
