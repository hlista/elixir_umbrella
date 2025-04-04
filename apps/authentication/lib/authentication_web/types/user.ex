defmodule AuthenticationWeb.Types.User do
  use Absinthe.Schema.Notation
  alias Authentication.Accounts.User

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  extend schema do
    directive(:link,
      url: "https://specs.apollo.dev/federation/v2.3",
      import: ["@key"]
    )
  end

  object :user do
    directive :key, fields: "id"

    # Any subgraph contributing fields MUST define a _resolve_reference field.
    field :_resolve_reference, :user do
      resolve dataloader(AuthenticationWeb.Loader, fn _parent, args, _res ->
                %{batch: {{:one, User}, %{}}, user: [id: args.id]}
              end)
    end
    field :id, non_null(:id)
    field :email, :string
    field :name, :string
    field :profile_picture, :string
    field :role, :string
    field :is_active, :boolean
  end
end
