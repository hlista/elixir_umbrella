defmodule AuthenticationService.Accounts do
  alias AuthenticationService.Repo
  alias AuthenticationService.Accounts.{User, OAuthAccount}

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

    case Repo.get_by(OAuthAccount, provider: provider, provider_uid: uid) do
      nil ->
        user =
          %User{}
          |> User.changeset(%{
            email: email,
            name: name,
            profile_picture: avatar,
            last_login_at: DateTime.utc_now()
          })
          |> Repo.insert!()

        %OAuthAccount{}
        |> OAuthAccount.changeset(Map.merge(oauth_data, %{user_id: user.id}))
        |> Repo.insert!()

        {:ok, user}

      oauth_account ->
        user = Repo.get!(User, oauth_account.user_id)

        oauth_account
        |> OAuthAccount.changeset(oauth_data)
        |> Repo.update()

        {:ok, user}
    end
  end
end
