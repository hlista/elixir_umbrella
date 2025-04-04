defmodule Authentication.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string
      add :profile_picture, :string
      add :role, :string, default: "user"
      add :is_active, :boolean, default: true
      add :last_login_at, :utc_datetime

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
