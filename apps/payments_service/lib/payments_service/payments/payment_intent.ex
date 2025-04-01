defmodule PaymentsService.Payments.PaymentIntent do
  use PaymentsService.Schema
  import Ecto.Changeset

  @required_fields [:external_id, :status, :amount, :currenty, :payment_method, :user_id]
  @fields [:metadata] ++ @required_fields

  schema "payment_intents" do
    field :external_id, :string # Stripe/PayPal ID
    field :status, :string # pending, succeeded, failed
    field :amount, :integer
    field :currency, :string
    field :payment_method, :string
    field :user_id, :binary_id
    field :metadata, :map

    timestamps()
  end

  def create_changeset(params) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(payment_intent, params \\ %{}) do
    payment_intent
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
