defmodule AuthenticationWeb.Queries.User do
  use Absinthe.Schema.Notation

  alias AuthenticationWeb.Resolvers
  object :user_queries do
    field :me, :user do
      resolve &Resolvers.Users.get_current_user/2
    end
  end
end
