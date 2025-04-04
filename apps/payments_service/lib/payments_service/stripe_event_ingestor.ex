defmodule PaymentsService.StripeEventIngestor do
  use Broadway

  alias Broadway.Message
  alias PaymentsService.StripeEventHandler

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {BroadwaySQS.Producer,
          queue_name: "payment-events",
          config: [
            access_key_id: "your-key",
            secret_access_key: "your-secret",
            region: "your-region"
          ]
        },
        concurrency: 2
      ],
      processors: [
        default: [concurrency: 10]
      ]
    )
  end

  def handle_message(_processor, %Message{data: raw_payload} = msg, _context) do
    with {:ok, event} <- Jason.decode(raw_payload),
         :ok <- StripeEventHandler.handle(event) do
      msg
    else
      error ->
        Message.failed(msg, error)
    end
  end
end
