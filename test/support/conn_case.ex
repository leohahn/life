defmodule Life.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate
  import Life.Factory
  import Plug.Conn, only: [put_req_header: 3]

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Life.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import Life.Router.Helpers
      import Life.Factory # Add factory to facilitate database insertion.
      # The default endpoint for testing
      @endpoint Life.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Life.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Life.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()
    case tags[:login_as] do
      nil ->
        {:ok, conn: conn}

      username ->
        user = insert(:user, username: username)
        {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)
        {:ok, %{conn: put_req_header(conn, "authorization", "Bearer #{jwt}"),
                user: user}}
    end
  end
end
