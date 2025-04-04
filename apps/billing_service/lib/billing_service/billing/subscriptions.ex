defmodule BillingService.Billing.Subscriptions do
  schema "subscriptions" do
    field :user_id, :binary_id
    field :plan_id, :binary_id
    field :status, :string # active, past_due, canceled
    field :current_period_end, :utc_datetime

    timestamps()
  end
end
