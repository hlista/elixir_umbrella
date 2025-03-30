defmodule AuthenticationWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  import Absinthe.Resolution.Helpers, only: [on_load: 2, dataloader: 2]

  extend schema do
    directive :link,
      url: "https://specs.apollo.dev/federation/v2.3",
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

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(AuthenticationWeb.Loader, Dataloader.Ecto.new(AthenticationService.Repo))

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do

  end

end
