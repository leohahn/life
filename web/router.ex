defmodule Life.Router do
  use Life.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Life do
    pipe_through :api

    #resources "/session", SessionController, [:create, :delete]
    resources "/users", UserController, [:create, :show]
    resources "/games", GameController, only: [:index, :show]
  end
end
