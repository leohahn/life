ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Life.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)

