defmodule Life.GameControllerTest do
  use Life.ConnCase
  use Life.Web, :controller

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert(:user, username: username)
      {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)
      # {:ok, %{user: user, jwt: jwt, claims: full_claims}}
      {:ok, %{conn: put_req_header(conn, "authorization", "Bearer #{jwt}"),
              user: user}}
    else
      {:ok, config}
    end
  end

  test "user needs to be authenticated", %{conn: conn} do
    conn1 = get conn, game_path(conn, :index)
    assert json_response(conn1, 401) == render_error_json("401.json")

    conn2 = get conn, game_path(conn, :show, 1)
    assert json_response(conn2, 401) == render_error_json("401.json")
  end

  @tag login_as: "max"
  test "user cann see all his games", %{conn: conn, user: user} do
    other_user = insert(:user, username: "otherguy")

    max_game1 = insert(:game, name: "Game 1", user: user)
    max_game2 = insert(:game, name: "Game 2", user: user)
    _ = insert(:game, name: "Not Max's game", user: other_user)

    new_conn = get conn, game_path(conn, :index)
    assert json_response(new_conn, 200) ==
      render_json("index.json", games: [max_game2, max_game1])
  end

  @tag login_as: "max"
  test "user can see a specific game of his", %{conn: conn, user: user} do
    other_user = insert(:user, username: "otherguy")

    max_game = insert(:game, name: "Game 1", user: user)
    not_max_game = insert(:game, name: "Not Max's game", user: other_user)

    new_conn = get conn, game_path(conn, :show, not_max_game.id)
    assert json_response(new_conn, 404) ==
      render_error_json("404.json")

    new_conn = get conn, game_path(conn, :show, max_game.id)
    assert json_response(new_conn, 200) ==
      render_json("show.json", game: max_game)
  end

  defp render_json(template, assigns) do
    Life.GameView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

  defp render_error_json(template, assigns \\ %{}) do
    Life.ErrorView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end
end
