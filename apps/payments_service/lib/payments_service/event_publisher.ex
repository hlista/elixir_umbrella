defmodule PaymentsService.EventPublisher do
  use GenServer
  require Logger

  @exchange "app.events"

  def start_link(_opts), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def init(_) do
    {:ok, conn} = AMQP.Connection.open()
    {:ok, chan} = AMQP.Channel.open(conn)
    AMQP.Exchange.declare(chan, @exchange, :fanout, durable: true)
    {:ok, %{chan: chan}}
  end

  def publish(event) do
    GenServer.cast(__MODULE__, {:publish, event})
  end

  def handle_cast({:publish, event}, %{chan: chan} = state) do
    payload = Jason.encode!(event)
    AMQP.Basic.publish(chan, @exchange, "", payload)
    Logger.info("[EventBus] Published event: #{event["type"]}")
    {:noreply, state}
  end
end
