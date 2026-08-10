defmodule SjrWeb.Plugs.VisitorCounter do
  @moduledoc "Increments the visitor counter once per page view."
  @behaviour Plug

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    Sjr.VisitorCounter.increment()
    conn
  end
end
