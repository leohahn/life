defmodule Life.User do
  use Life.Web, :model

  alias Life.Repo
  alias Life.User

  import Comeonin.Bcrypt,
    only: [checkpw: 2, dummy_checkpw: 0, hashpwsalt: 1]

  @all_fields [:name, :username, :password]
  @required_fields [:username, :password]

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :games, Life.Game

    timestamps()
  end

  def changeset(struct, params \\ []) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> validate_length(:username, min: 3, max: 20)
  end

  def registration_changeset(struct, params \\ []) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> validate_length(:username, min: 3, max: 20)
    |> validate_length(:password, min: 6, max: 20)
    |> put_password_hash()
    |> unique_constraint(:username)
  end

  def find_and_confirm_password(username, given_pass) do
    case Repo.get_by(User, username: username) do
      nil ->
        dummy_checkpw()
        {:error, :not_found}

      user ->
        if checkpw(given_pass, user.password_hash) do
          {:ok, user}
        else
          {:error, :unauthorized}
        end
    end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
