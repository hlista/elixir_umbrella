defmodule PaymentsService.Payments do
  alias PaymentsService.Repo
  alias PaymentsService.Payments.PaymentIntent
  alias EctoShorts.Actions
  @repo [repo: PaymentsService.Repo]

  def create_payment_intent(params) do
    Actions.create(PaymentIntent, params, @repo)
  end

  def update_payment_intent(schema, params) do
    Actions.update(PaymentIntent, schema, params, @repo)
  end

  def find_payment_intent(params) do
    Actions.find(PaymentIntent, params, @repo)
  end
end
