defmodule Life.UserView do
  use Life.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render("user.json", %{user: user})}
  end

  def render("user.json", %{user: user}) do
    %{username: user.username,
      name: user.name}
  end

  def render("error.json", params) do
    Life.ChangesetView.render("error.json", params)
  end

  def render("404.json", params) do
    Life.ErrorView.render("404.json", params)
  end
end
