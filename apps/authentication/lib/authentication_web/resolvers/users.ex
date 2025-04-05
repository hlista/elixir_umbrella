defmodule AuthenticationWeb.Resolvers.Users do
  def get_current_user(_,%{context: %{current_user: %{id: user_id}}}) do
    Authentication.Accounts.find_user(%{id: user_id})
  end
  def get_current_user(_, _) do
    {:ok, %{
      id: "1",
      email: "foo@bar.com",
      name: "foo_bar",
      profile_picture: "image.png",
      role: "user",
      is_active: true
    }}
  end
end
