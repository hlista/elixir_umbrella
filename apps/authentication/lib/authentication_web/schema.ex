defmodule AuthenticationWeb.Schema do
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

  import_types AuthenticationWeb.Types.User
  import_types AuthenticationWeb.Queries.User

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(AuthenticationWeb.Loader, Dataloader.Ecto.new(Authentication.Repo))

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields :user_queries
  end
end
