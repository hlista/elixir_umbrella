defmodule AuthenticationService.Accounts.User do
  use AuthenticationService.Schema
  import Ecto.Changeset

  @required_fields [:email, :name]
  @fields [:profile_picture, :role, :is_active, :last_login_at] ++ @required_fields

  schema "users" do
    field :email, :string
    field :name, :string
    field :profile_picture, :string
    field :role, :string, default: "user"
    field :is_active, :boolean, default: true
    field :last_login_at, :utc_datetime

    has_many :oauth_accounts, AuthenticationService.Accounts.OAuthAccount

    timestamps()
  end

  def create_changeset(params) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
