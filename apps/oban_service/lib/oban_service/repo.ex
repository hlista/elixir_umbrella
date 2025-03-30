defmodule ObanService.Repo do
  use Ecto.Repo,
    otp_app: :oban_service,
    adapter: Ecto.Adapters.Postgres
end
