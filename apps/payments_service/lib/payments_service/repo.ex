defmodule PaymentsService.Repo do
  use Ecto.Repo,
    otp_app: :payments_service,
    adapter: Ecto.Adapters.Postgres
end
