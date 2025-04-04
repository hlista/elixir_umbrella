defmodule BillingService.BillingEventPipeline do
  use Broadway
  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {BroadwayRabbitMQ.Producer,
          queue: "billing_events",
          connection: [
            host: "localhost"
          ],
          declare: [durable: true]
        },
        concurrency: 1
      ],
      processors: [default: [concurrency: 5]]
    )
  end

  def handle_message(_processor, %Message{data: raw} = msg, _ctx) do
    case Jason.decode(raw) do
      {:ok, %{"type" => "payment_intent.succeeded", "data" => data}} ->
        Billing.Invoices.mark_as_paid(data["invoice_id"])
        msg

      _ -> Message.failed(msg, "Invalid or unknown event")
    end
  end
end
