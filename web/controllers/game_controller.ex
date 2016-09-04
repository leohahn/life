defmodule Life.GameController do
  use Life.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def index(conn, _params, current_user) do
    games =
      current_user
      |> query_user_games
      |> Repo.all()
    render(conn, "index.json", games: games)
  end

  def show(conn, %{"id" => id}, current_user) do
    case Repo.get(query_user_games(current_user), id) do
      nil ->
        conn
        |> put_status(404)
        |> render(Life.ErrorView, "404.json", %{})

      game ->
        render(conn, "show.json", game: game)
    end
  end

  # Query that gets all games from a specific user.
  defp query_user_games(user) do
    from g in Life.Game, where: g.user_id == ^user.id
  end

  # This function is called whenever the user is not on the
  # authorization header. It always return a 401 status.
  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(Life.ErrorView, "401.json", %{})
  end

  # Overwrites the action function, so that it always passes the
  # current user as the last parameter.
  def action(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    args = [conn, conn.params, user]
    apply(__MODULE__, action_name(conn), args)
  end
end
