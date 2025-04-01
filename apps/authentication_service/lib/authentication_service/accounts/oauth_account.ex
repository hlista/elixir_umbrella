defmodule AuthenticationService.Accounts.OAuthAccount do
  use AuthenticationService.Schema
  import Ecto.Changeset

  @required_fields [:provider, :provider_uid, :access_token, :token_expires_at, :user_id]
  @fields @required_fields ++ [:refresh_token]

  schema "oauth_accounts" do
    field :provider, :string  # "google", "github", "apple", etc.
    field :provider_uid, :string  # unique user id from the provider
    field :access_token, :string
    field :refresh_token, :string
    field :token_expires_at, :utc_datetime

    belongs_to :user, AuthenticationService.Accounts.User

    timestamps()
  end

  def create_changeset(params) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(oauth_account, params \\ %{}) do
    oauth_account
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
