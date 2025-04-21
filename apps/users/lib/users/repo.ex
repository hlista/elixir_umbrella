defmodule Users.Repo do
  use Ecto.Repo,
    otp_app: :users,
    adapter: Ecto.Adapters.SQLite3
end
