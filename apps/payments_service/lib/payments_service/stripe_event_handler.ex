defmodule PaymentsService.StripeEventHandler do
  alias PaymentsService.EventPublisher

  def handle(%{"type" => "invoice.payment_succeeded", "data" => %{"object" => invoice}}) do
    EventPublisher.publish(%{
      "type" => "invoice.payment_succeeded",
      "data" => %{
        "invoice_id" => invoice["id"],
        "user_id" => invoice["customer"],
        "amount" => invoice["amount_paid"],
        "subscription_id" => invoice["subscription"]
      },
      "source" => "payments",
      "timestamp" => DateTime.utc_now()
    })

    :ok
  end

  def handle(%{"type" => "payment_intent.succeeded", "data" => %{"object" => intent}}) do
    EventPublisher.publish(%{
      "type" => "payment_intent.succeeded",
      "data" => %{
        "payment_intent_id" => intent["id"],
        "user_id" => intent["metadata"]["user_id"],
        "amount" => intent["amount"],
        "currency" => intent["currency"]
      },
      "source" => "payments",
      "timestamp" => DateTime.utc_now()
    })

    :ok
  end

  def handle(_), do: :ok
end
