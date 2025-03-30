defmodule AuthenticationService.Token do
  use Joken.Config

  def generate_token(user) do
    generate_and_sign(%{"user_id" => user.id, "email" => user.email})
  end
end
