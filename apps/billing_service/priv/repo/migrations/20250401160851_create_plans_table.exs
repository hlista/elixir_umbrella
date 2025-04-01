defmodule BillingService.Repo.Migrations.CreatePlansTable do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string
      add :price, :integer
      add :interval, :string

      timestamps()
    end
  end
end
