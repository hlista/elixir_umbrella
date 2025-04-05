defmodule ProductsWeb.Plug.UserPlug do
  import Plug.Conn

  @behaviour Plug

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts \\ []) do
    with {:ok, jwt_token} <- get_jwt(conn),
         {:ok, %{
          "email" => email,
          "user_id" => user_id
          }} <-
            Authentication.Token.verify_and_validate(jwt_token) do
      Absinthe.Plug.assign_context(conn, %{
        current_user: %{
          id: user_id,
          email: email
        }
      })
    else
      _ -> conn
    end
  end

  defp get_jwt(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> jwt_token] -> {:ok, jwt_token}
      _ -> {:error, "not authorized"}
    end
  end
end
