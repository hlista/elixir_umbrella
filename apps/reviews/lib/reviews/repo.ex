defmodule Reviews.Repo do
  use Ecto.Repo,
    otp_app: :reviews,
    adapter: Ecto.Adapters.SQLite3
end
