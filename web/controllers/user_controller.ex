defmodule Life.UserController do
  use Life.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated,
    [handler: __MODULE__] when action in [:show]

  alias Life.User
  alias Life.ChangesetView

  def show(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      nil ->
        render(conn, "404.json")

      user ->
        render(conn, "show.json", %{user: user})
    end
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)

      {:error, changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(Life.ErrorView, "401.json")
  end
end
