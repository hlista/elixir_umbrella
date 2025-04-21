defmodule Reviews.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :rating, :string
      add :product_id, :integer
      add :user_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
