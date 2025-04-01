defmodule BillingService.Repo.Migrations.CreateSubscriptionsTable do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :user_id, :binary_id, null: false
      add :plan_id, references(:plans, on_delete: :delete_all), null: false
      add :status, :string
      add :current_period_end, :naive_datetime

      timestamps()
    end
  end
end
