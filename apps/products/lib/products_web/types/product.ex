defmodule ProductsWeb.Types.Product do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  object :product do
    directive :key, fields: "id"

    # Any subgraph contributing fields MUST define a _resolve_reference field.
    field :_resolve_reference, :product do
      {:ok, %{id: 4, name: "example product"}}
    end
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :price, :integer
  end
end
