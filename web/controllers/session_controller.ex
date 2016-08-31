defmodule Life.SessionController do
  use Life.Web, :controller

  alias Life.User

  def create(conn, %{"session" => %{"username" => user,
                                    "password" => pass}}) do
    case User.find_and_confirm_password(user, pass) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", "#{exp}")
        |> render("login.json", user: user, jwt: jwt, exp: exp)

      {:error, :unauthorized} ->
        conn
        |> put_status(401)
        |> render(Life.ErrorView, "401.json", %{})

      {:error, :not_found} ->
        conn
        |> put_status(404)
        |> render(Life.ErrorView, "404.json", %{})
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> send_resp(200, "")
  end
end
