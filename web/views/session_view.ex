defmodule Life.SessionView do
  use Life.Web, :view

  def render("login.json", %{user: user, jwt: jwt, exp: exp}) do
    %{"data" => %{"user" => render_user(user),
                  "jwt" => jwt,
                  "exp" => exp}}
  end

  defp render_user(user) do
    %{"username" => user.username,
      "name" => user.name}
  end
end
