defmodule BillingService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BillingService.Repo,
      {DNSCluster, query: Application.get_env(:billing_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: BillingService.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: BillingService.Finch}
      # Start a worker by calling: BillingService.Worker.start_link(arg)
      # {BillingService.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: BillingService.Supervisor)
  end
end
