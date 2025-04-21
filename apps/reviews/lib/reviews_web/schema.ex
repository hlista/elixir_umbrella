defmodule ReviewsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema
  alias ReviewsWeb.ReviewsResolver

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

    field :reviews, list_of(:review) do
      resolve(fn entity, _info, _ ->
        ReviewsResolver.resolve_users_reviews(entity)
      end)
    end
  end

  object :product do
    directive :key, fields: "id"

    field :_resolve_reference, :product do
      resolve(fn %{id: id}, _info ->
        {:ok, %{__typename: "Product", id: id}}
      end)
    end

    field :id, non_null(:integer)

    field :reviews, list_of(:review) do
      resolve(fn entity, _info, _ ->
        ReviewsResolver.resolve_products_reviews(entity)
      end)
    end
  end

  object :review do
    directive :key, fields: "id"

    field :_resolve_reference, :review do
      resolve &ReviewsResolver.find_by_id/2
    end

    field :id, non_null(:integer)
    field :rating, :string

    field :user, :user do
      resolve(fn entity, _, _ ->
        {:ok, %{__typename: "User", id: entity.user_id}}
      end)
    end

    field :product, :product do
      resolve(fn entity, _, _ ->
        {:ok, %{__typename: "Product", id: entity.product_id}}
      end)
    end
  end

  query do
    field :reviews, non_null(list_of(:review)) do
      resolve(&ReviewsResolver.all/2)
    end
  end
end
