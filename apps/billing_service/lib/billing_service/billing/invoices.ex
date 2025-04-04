defmodule BillingService.Billing.Invoices do
  schema "invoices" do
    field :user_id, :binary_id
    field :subscription_id, :binary_id
    field :amount_due, :integer
    field :status, :string # paid, unpaid, failed
    field :due_date, :utc_datetime
    field :payment_intent_id, :binary_id

    timestamps()
  end
end
