defmodule PaymentsService.Schema do
  defmacro __using__(opts) do
    use Ecto.Schema, unquote(opts)

    @primary_key {:id, :binary_id, autogenerate: true}
    @foreign_key_type :binary_id
  end
end
