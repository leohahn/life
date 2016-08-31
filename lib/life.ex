defmodule Life do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Start the Ecto repository
      supervisor(Life.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Life.Endpoint, []),
      # Start your own worker by calling: Life.Worker.start_link(arg1, arg2, arg3)
      # worker(Life.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: Life.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Life.Endpoint.config_change(changed, removed)
    :ok
  end
end
