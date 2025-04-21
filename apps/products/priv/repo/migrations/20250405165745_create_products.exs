defmodule Products.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :user_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
