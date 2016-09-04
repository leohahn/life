defmodule Life.GameController do
  use Life.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def index(conn, _params, current_user) do
    games = Repo.all(Life.Game)
    render(conn, "index.json", games: games)
  end

  def show(conn, %{"id" => id}, current_user) do
    case Repo.get(Life.Game, id) do
      game ->
        render(conn, "show.json", game: game)

      nil ->
        render(conn, "404.json")
    end
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(Life.ErrorView, "401.json", %{})
  end

  def action(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    args = [conn, conn.params, user]
    apply(__MODULE__, action_name(conn), args)
  end
end
