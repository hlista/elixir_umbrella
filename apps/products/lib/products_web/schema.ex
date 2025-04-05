defmodule ProductsWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.7",
      import: [
        "@key",
        "@shareable",
        "@provides",
        "@requires",
        "@external",
        "@tag",
        "@extends",
        "@override",
        "@inaccessible",
        "@composeDirective",
        "@interfaceObject"
      ]
  end

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  import_types ProductsWeb.Types.Product
  import_types ProductsWeb.Types.User

  import_types ProductsWeb.Queries.Product
  #import_types ProductsWeb.Mutations.Product

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(ProductsWeb.Loader, Dataloader.Ecto.new(Products.Repo))

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields :product_queries
  end

  # mutation do
  #   import_fields :product_mutations
  # end
end
