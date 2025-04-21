defmodule UsersWeb.UsersResolver do
  alias Users.Repo
  alias Users.Accounts.User

  def find_by_id(%{id: id}, _) do
    {:ok, Repo.get(User, id)}
  end

  def all(_, _) do
    {:ok, Repo.all(User)}
  end
end
