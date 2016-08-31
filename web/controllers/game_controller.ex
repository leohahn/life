defmodule Life.GameController do
  use Life.Web, :controller

  def index(conn, _params) do
    games = Repo.all(Life.Game)
    render(conn, "index.json", games: games)
  end

  def show(conn, %{"id" => id}) do
    case Repo.get(Life.Game, id) do
      game ->
        render(conn, "show.json", game: game)

      nil ->
        render(conn, "404.json")
    end
  end
end
