defmodule Reviews.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :rating, :string
    field :product_id, :integer
    field :user_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:rating, :product_id, :user_id])
    |> validate_required([:rating, :product_id, :user_id])
  end
end
