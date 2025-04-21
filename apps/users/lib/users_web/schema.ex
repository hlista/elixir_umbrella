defmodule UsersWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema
  alias UsersWeb.UsersResolver

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: [
        "@key", "@requires"
      ]
  end

  object :user do
    directive :key, fields: "id"

    field :_resolve_reference, :user do
      resolve &UsersResolver.find_by_id/2
    end

    field :id, non_null(:integer)
    field :email, :string
    field :name, :string
  end

  query do
    field :users, non_null(list_of(:user)) do
      resolve(&UsersResolver.all/2)
    end
  end
end
