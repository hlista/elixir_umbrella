defmodule ProductsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema
  alias ProductsWeb.ProductsResolver

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: [
        "@key"
      ]
  end

  object :user do
    directive :key, fields: "id"

    field :_resolve_reference, :user do
      resolve(fn %{id: id}, _info ->
        {:ok, %{__typename: "User", id: id}}
      end)
    end

    field :id, non_null(:integer)

    field :products, list_of(:product) do
      resolve(fn entity, _info, _ ->
        ProductsResolver.resolve_users_products(entity)
      end)
    end
  end

  object :product do
    directive :key, fields: "id"

    field :_resolve_reference, :product do
      resolve &ProductsResolver.find_by_id/2
    end

    field :id, non_null(:integer)

    field :name, :string

    field :user, :user do
      resolve(fn entity, _info, _ ->
        {:ok, %{__typename: "User", id: entity.user_id}}
      end)
    end
  end

  query do
    field :products, non_null(list_of(:product)) do
      resolve(&ProductsResolver.all/2)
    end
  end
end
