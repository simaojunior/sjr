defmodule SjrWeb.Plugs.VisitorCounter do
  @moduledoc "Increments the visitor counter once per browser session."
  @behaviour Plug

  import Plug.Conn

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    if get_session(conn, :counted) do
      conn
    else
      Sjr.VisitorCounter.increment()
      put_session(conn, :counted, true)
    end
  end
end
