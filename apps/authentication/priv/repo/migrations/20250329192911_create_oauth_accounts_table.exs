defmodule Authentication.Repo.Migrations.CreateOauthAccountsTable do
  use Ecto.Migration

  def change do
    create table(:oauth_accounts) do
      add :provider, :string, null: false
      add :provider_uid, :string, null: false
      add :access_token, :string
      add :refresh_token, :string
      add :token_expires_at, :utc_datetime
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:oauth_accounts, [:provider, :provider_uid])
  end
end
