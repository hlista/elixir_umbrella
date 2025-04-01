defmodule Payments.BroadwayProcessor.PaymentEventHandler do
  alias Payments.Events

  def process(%{"type" => "payment_intent.succeeded", "data" => %{"object" => payment}}) do
    Events.mark_as_paid(payment["id"])
    :ok
  end

  def process(%{"type" => "invoice.payment_failed", "data" => %{"object" => invoice}}) do
    Events.flag_as_failed(invoice["id"])
    :ok
  end

  def process(_event), do: :ok
end
