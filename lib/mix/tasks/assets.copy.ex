defmodule Mix.Tasks.Assets.Copy do
  @shortdoc "Copies assets/ into priv/static/assets/"

  @moduledoc """
  Copies the hand-authored CSS/JS in `assets/` to `priv/static/assets/`.

  The design ships as finished CSS with no build step, and the only JS is
  a small theme-toggle script — so there's nothing to bundle or compile,
  just files to place where `Plug.Static` and `phx.digest` can find them.
  """

  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    dest = Path.join([File.cwd!(), "priv", "static", "assets"])
    File.rm_rf!(dest)
    File.mkdir_p!(dest)
    File.cp_r!(Path.join(File.cwd!(), "assets/css"), Path.join(dest, "css"))
    File.cp_r!(Path.join(File.cwd!(), "assets/js"), Path.join(dest, "js"))
    Mix.shell().info("Copied assets/{css,js} -> priv/static/assets/")
  end
end
