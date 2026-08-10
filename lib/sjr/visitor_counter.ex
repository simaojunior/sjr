defmodule Sjr.VisitorCounter do
  @moduledoc """
  A persistent visitor counter backed by a single file on a Fly volume.

  Deliberately not a database — one integer doesn't need one. The count is
  kept in GenServer state and flushed to disk on every increment so it
  survives restarts and deploys as long as the volume does.
  """
  use GenServer

  @name __MODULE__

  def start_link(_opts), do: GenServer.start_link(__MODULE__, :ok, name: @name)

  def increment, do: GenServer.call(@name, :increment)
  def current, do: GenServer.call(@name, :current)

  @impl GenServer
  def init(:ok), do: {:ok, read_count()}

  @impl GenServer
  def handle_call(:increment, _from, count) do
    new_count = count + 1
    write_count(new_count)
    {:reply, new_count, new_count}
  end

  def handle_call(:current, _from, count), do: {:reply, count, count}

  defp read_count do
    with {:ok, content} <- File.read(file_path()),
         {count, _} <- Integer.parse(String.trim(content)) do
      count
    else
      _ -> 0
    end
  end

  defp write_count(count) do
    path = file_path()
    File.mkdir_p!(Path.dirname(path))
    File.write!(path, Integer.to_string(count))
  end

  defp file_path, do: Application.fetch_env!(:sjr, :visitor_counter_path)
end
