defmodule Life.GameView do
  use Life.Web, :view

  def render("index.json", %{games: games}) do
    %{data: render_many(games, Life.GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, Life.GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id,
      name: game.name,
      state: game.state,
      dimension: game.dimension}
  end
end
