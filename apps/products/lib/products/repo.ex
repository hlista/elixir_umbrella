defmodule Products.Repo do
  use Ecto.Repo,
    otp_app: :products,
    adapter: Ecto.Adapters.SQLite3
end
