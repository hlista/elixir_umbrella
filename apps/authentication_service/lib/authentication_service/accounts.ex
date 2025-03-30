defmodule AuthenticationService.Accounts do
  alias AuthenticationService.Repo
  alias AuthenticationService.Accounts.{User, OAuthAccount}
  alias EctoShorts.Actions
  @repo [repo: AuthenticationService.Repo]

  def create_user(params, opts \\ []) do
    Actions.create(User, params, @repo)
  end

  def find_user(params, opts \\ []) do
    Actions.find(User, params, @repo)
  end

  def update_oauth_account(id, params, opts \\ []) do
    Actions.update(OAuthAccount, id, params, @repo)
  end

  def create_oauth_account(params, opts \\ []) do
    Actions.create(OAuthAccount, params, @repo)
  end

  def find_oauth_account(params, opts \\ []) do
    Actions.find(OAuthAccount, params, @repo)
  end

  def get_or_create_user_from_ueberauth(%Ueberauth.Auth{} = auth) do
    provider = to_string(auth.provider)
    uid = auth.uid
    email = auth.info.email
    name = auth.info.name || auth.info.nickname
    avatar = auth.info.image

    oauth_data = %{
      provider: provider,
      provider_uid: uid,
      access_token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      token_expires_at: DateTime.from_unix!(auth.credentials.expires_at || 0)
    }
    case find_oauth_account(%{
      provider: provider, provider_uid: uid
    }) do
      {:ok, oauth_account} ->
        find_user_and_update_oauth_account(oauth_account, oauth_data)
      {:error, _} ->
        create_user_and_oauth_account(%{
          email: email,
          name: name,
          profile_picture: avatar,
          last_login_at: DateTime.utc_now()
        }, oauth_data)
    end
  end

  defp create_user_and_oauth_account(user_params, oauth_data) do
    with {:ok, user} <- create_user(user_params),
    {:ok, _} <- create_oauth_account(
      Map.merge(oauth_data, %{user_id: user.id})
    ) do
      {:ok, user}
    end
  end

  defp find_user_and_update_oauth_account(oauth_account, oauth_data) do
    with {:ok, user} <- find_user(%{id: oauth_account.user_id}),
    {:ok, _} <- update_oauth_account(oauth_account, oauth_data) do
      {:ok, user}
    end
  end
end
