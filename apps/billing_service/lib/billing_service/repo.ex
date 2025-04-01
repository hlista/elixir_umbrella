defmodule BillingService.Repo do
  use Ecto.Repo,
    otp_app: :billing_service,
    adapter: Ecto.Adapters.Postgres
end
