defmodule Life.GameControllerTest do
  use Life.ConnCase
  alias Life.Game


  test "Listing all games", %{conn: conn} do
    game1 = insert_game("GUEIMI")
    conn = get conn, game_path(conn, :index)

    assert json_response(conn, 200)["data"] ==
      [game_to_json(game1)]

    game2 = insert_game("GUEIMI DOIS")
    conn = get conn, game_path(conn, :index)

    assert json_response(conn, 200)["data"] ==
      [game_to_json(game1), game_to_json(game2)]
  end

  test "List one game by id", %{conn: conn} do
    game1 = insert_game("Pokemon")
    conn = get conn, game_path(conn, :show, game1.id)

    assert json_response(conn, 200)["data"] ==
      game_to_json(game1)
  end

  defp game_to_json(game) do
    %{"id" => game.id,
      "dimension" => game.dimension,
      "state" => game.state,
      "name" => game.name}
  end

  defp insert_game(name) do
    Repo.insert!(%Game{name: name, dimension: 2, state: [1,2,3,4]})
  end
end
