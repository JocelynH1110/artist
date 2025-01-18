defmodule Artist.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ArtistWeb.Telemetry,
      Artist.Repo,
      {DNSCluster, query: Application.get_env(:artist, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Artist.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Artist.Finch},
      # Start a worker by calling: Artist.Worker.start_link(arg)
      # {Artist.Worker, arg},
      # Start to serve requests, typically the last entry
      ArtistWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Artist.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ArtistWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
