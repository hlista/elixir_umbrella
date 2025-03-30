defmodule ObanService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ObanService.Repo,
      {DNSCluster, query: Application.get_env(:oban_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ObanService.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ObanService.Finch}
      # Start a worker by calling: ObanService.Worker.start_link(arg)
      # {ObanService.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ObanService.Supervisor)
  end
end
