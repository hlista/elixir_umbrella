defmodule ProductsWeb.ProductsResolver do
  alias Products.Repo
  alias Products.Inventory.Product
  import Ecto.Query, only: [from: 2]

  def find_by_id(%{id: id}, _) do
    {:ok, Repo.get(Product, id)}
  end

  def resolve_users_products(%{id: user_id}) do
    {:ok,
      Repo.all(from(p in Product, where: p.user_id == ^user_id))
    }
  end

  def resolve_reviews_product(%{product_id: product_id} = entity) do
    {:ok, Map.put(
      entity,
      :product,
      Repo.get(Product, product_id)
    )}
  end

  def all(_, _) do
    {:ok, Repo.all(Product)}
  end
end
