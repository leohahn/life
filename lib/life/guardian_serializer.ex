defmodule Life.GuardianSerializer do
  @moduledoc """
  This module implements a simple serializer for Guardian tokens.
  It transforms a User model into a unique string, as well as parsing
  this unique string into a User model.
  """
  @behaviour Guardian.Serializer

  alias Life.Repo
  alias Life.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type."}

  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: {:error, "Unknown resource type."}
end
