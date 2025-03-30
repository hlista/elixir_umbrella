defmodule AuthenticationService.Repo do
  use Ecto.Repo,
    otp_app: :authentication_service,
    adapter: Ecto.Adapters.Postgres
end
