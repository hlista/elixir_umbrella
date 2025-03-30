defmodule AuthenticationService.Token do
  use Joken.Config

  def generate_token(user) do
    generate_and_sign(%{
      "user_id" => user.id,
      "email" => user.email,
      "name" => user.name,
      "role" => user.role,
      "profile_picture" => user.profile_picture
    })
  end
end
