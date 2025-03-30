defmodule AuthenticationService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuthenticationService.Repo,
      {DNSCluster, query: Application.get_env(:authentication_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AuthenticationService.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AuthenticationService.Finch}
      # Start a worker by calling: AuthenticationService.Worker.start_link(arg)
      # {AuthenticationService.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: AuthenticationService.Supervisor)
  end
end
