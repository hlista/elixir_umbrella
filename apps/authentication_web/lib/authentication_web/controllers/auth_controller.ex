defmodule AuthenticationWeb.AuthController do
  use AuthenticationWeb, :controller
  plug Ueberauth

  alias AuthenticationService.Accounts
  alias AuthenticationService.Token

  def request(conn, _params), do: conn

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.get_or_create_user_from_ueberauth(auth) do
      {:ok, user} ->
        {:ok, jwt, _} = Token.generate_token(user)
        json(conn, %{token: jwt})

      {:error, reason} ->
        conn
        |> put_flash(:error, "Authentication failed: #{reason}")
        |> redirect(to: "/")
    end
  end

  def callback(%{assigns: %{ueberauth_failure: failure}} = conn, _params) do
    IO.inspect(failure, label: "Ueberauth Failure")
    conn
    |> put_flash(:error, "Auth failed")
    |> redirect(to: "/")
  end
end
