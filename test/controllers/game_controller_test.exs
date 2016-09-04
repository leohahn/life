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
    conn = get conn, game_path(conn, :index)
    assert json_response(conn, 401) == render_error_json("401.json")
  end

  defp render_json(template, assigns \\ %{}) do
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
