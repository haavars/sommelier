defmodule Sommelier.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SommelierWeb.Telemetry,
      # Start the Ecto repository
      Sommelier.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Sommelier.PubSub},
      # Start Finch
      {Finch, name: Sommelier.Finch},
      # Start the Endpoint (http/https)
      SommelierWeb.Endpoint
      # Start a worker by calling: Sommelier.Worker.start_link(arg)
      # {Sommelier.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Sommelier.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SommelierWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
