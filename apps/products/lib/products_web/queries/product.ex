defmodule ProductsWeb.Queries.Product do
  use Absinthe.Schema.Notation

  alias AuthenticationWeb.Resolvers
  object :product_queries do
    field :product, :product do
      IO.inspect("here")
      {:ok, %{id: "4", name: "example product", user_id: "123"}}
    end
  end
end
