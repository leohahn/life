defmodule Life.Router do
  use Life.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  post "/api/users", Life.UserController, :create
  post "/api/sessions", Life.SessionController, :create
  # Rest of /api is secured through JWT.
  scope "/api", Life do
    pipe_through [:api, :api_auth]
    # Logout
    delete "/sessions", SessionController, :delete
    resources "/users", UserController, only: [:show]
    resources "/games", GameController, only: [:index, :show]
  end
end
