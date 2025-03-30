defmodule AuthenticationWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Federation.Schema

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  import_types AuthenticationWeb.Types.User

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
