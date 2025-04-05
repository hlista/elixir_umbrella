defmodule ProductsWeb.Types.User do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  object :user do
    directive :key, fields: "id"

    # In this case, only the `Inventory.Schema` should resolve the `inStock` field.
    field :_resolve_reference, :user do
      resolve(fn %{__typename: "User", id: id} = entity, _info ->
        {:ok, Map.merge(entity, %{products: []})}
      end)
    end

    field :id, non_null(:id)
    field :products, list_of(:product)
  end
end
