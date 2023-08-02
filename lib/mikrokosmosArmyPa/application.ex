defmodule MikrokosmosArmyPa.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MikrokosmosArmyPaWeb.Telemetry,
      # Start the Ecto repository
      MikrokosmosArmyPa.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: MikrokosmosArmyPa.PubSub},
      # Start Finch
      {Finch, name: MikrokosmosArmyPa.Finch},
      # Start the Endpoint (http/https)
      MikrokosmosArmyPaWeb.Endpoint
      # Start a worker by calling: MikrokosmosArmyPa.Worker.start_link(arg)
      # {MikrokosmosArmyPa.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MikrokosmosArmyPa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MikrokosmosArmyPaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
