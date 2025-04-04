defmodule AuthenticationWeb.Resolvers.Users do
  def get_current_user(_,%{context: %{current_user: %{id: user_id}}}) do
    Authentication.Accounts.find_user(%{id: user_id})
  end
  def get_current_user(_, _) do
    {:error, "Not logged in"}
  end
end
