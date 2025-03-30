defmodule AuthenticationWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuthenticationWeb.Telemetry,
      # Start a worker by calling: AuthenticationWeb.Worker.start_link(arg)
      # {AuthenticationWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      AuthenticationWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuthenticationWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuthenticationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
