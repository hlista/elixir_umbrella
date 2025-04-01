defmodule PaymentsService.Repo.Migrations.CreatePaymentTable do
  use Ecto.Migration

  def change do
    create table(:payment_intents) do
      add :external_id, :string # Stripe/PayPal ID
      add :status, :string # pending, succeeded, failed
      add :amount, :integer
      add :currency, :string
      add :payment_method, :string
      add :user_id, :binary_id
      add :metadata, :map

      timestamps()
    end
  end
end
