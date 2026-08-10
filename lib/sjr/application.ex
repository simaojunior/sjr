defmodule Sjr.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      SjrWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:sjr, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Sjr.PubSub},
      # Start a worker by calling: Sjr.Worker.start_link(arg)
      # {Sjr.Worker, arg},
      # Start to serve requests, typically the last entry
      SjrWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sjr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl Application
  def config_change(changed, _new, removed) do
    SjrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
