defmodule BillingService.Repo.Migrations.CreateInvoicesTable do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :user_id, :binary_id, null: false
      add :subscription_id, references(:subscriptions, on_delete: :delete_all), null: false
      add :amount_due, :integer
      add :status, :string
      add :due_date, :naive_datetime
      add :payment_intent_id, :binary_id, null: false

      timestamps()
    end
  end
end
