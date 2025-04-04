defmodule PaymentsService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PaymentsService.Repo,
      {DNSCluster, query: Application.get_env(:payments_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PaymentsService.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PaymentsService.Finch},
      PaymentsService.BroadwayProcessor,
      PaymentsService.EventPublisher
      # Start a worker by calling: PaymentsService.Worker.start_link(arg)
      # {PaymentsService.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: PaymentsService.Supervisor)
  end
end
