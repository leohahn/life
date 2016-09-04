defmodule Life.GameViewTest do
  use Life.ConnCase

  alias Life.GameView

  test "index.json" do
    user = build(:user)
    game1 = build(:game, name: "Game 1", user: user)
    game2 = build(:game, name: "Game 2", user: user)

    assert GameView.render("index.json", games: [game1, game2]) ==
      %{data:
        [%{id: game1.id,
           name: game1.name,
           state: game1.state,
           dimension: game1.dimension},
         %{id: game2.id,
           name: game2.name,
           state: game2.state,
           dimension: game2.dimension}]}
  end

  test "show.json" do
    user = build(:user)
    game = build(:game, name: "Game 1", user: user)

    assert GameView.render("show.json", game: game) ==
      %{data:
        %{id: game.id,
          name: game.name,
          state: game.state,
          dimension: game.dimension}}
  end

  test "game.json" do
    user = build(:user)
    game = build(:game, name: "Game 1", user: user)

    assert GameView.render("game.json", game: game) ==
      %{id: game.id,
        name: game.name,
        state: game.state,
        dimension: game.dimension}
  end
end
