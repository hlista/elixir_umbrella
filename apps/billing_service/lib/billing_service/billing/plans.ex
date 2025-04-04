defmodule BillingService.Billing.Plans do
  schema "plans" do
    field :name, :string
    field :price, :integer
    field :interval, :string # monthly, yearly

    timestamps()
  end
end
