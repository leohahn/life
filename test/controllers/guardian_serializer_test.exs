defmodule Life.GuardianSerializerTest do
  use Life.ConnCase
  import Life.Factory

  test "same user should be corretly written and read as token." do
    user = insert(:user)
    {:ok, token} = Life.GuardianSerializer.for_token(user)
    {:ok, recovered_user} = Life.GuardianSerializer.from_token(token)

    assert token == "User:#{user.id}"
    assert recovered_user == user
  end
end
