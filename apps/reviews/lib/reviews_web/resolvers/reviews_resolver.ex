defmodule ReviewsWeb.ReviewsResolver do
  alias Reviews.Repo
  alias Reviews.Reviews.Review
  import Ecto.Query, only: [from: 2]

  def find_by_id(%{id: id}, _) do
    {:ok, Repo.get(Review, id)}
  end

  def resolve_users_reviews(%{id: user_id}) do
    {:ok,
      Repo.all(from(r in Review, where: r.user_id == ^user_id))
    }
  end

  def resolve_products_reviews(%{id: product_id}) do
    {:ok,
      Repo.all(from(r in Review, where: r.product_id == ^product_id))
    }
  end

  def all(_, _) do
    {:ok, Repo.all(Review)}
  end
end
