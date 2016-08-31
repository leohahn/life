defmodule Life.UserTest do
  use Life.ConnCase
  alias Life.User

  test "invalid user data should return an invalid changeset." do
    invalid_changeset = User.changeset(%User{}, %{
      name: "Leonardo",
      username: "lh", # less than 3
      password: "abcdef"
    })
    refute invalid_changeset.valid?

    invalid_changeset = User.changeset(%User{}, %{
      name: "Leonardo",
      username: "abcbsjaisjdiajdsiajds", # more than 20
      password: "abcdef"
    })
    refute invalid_changeset.valid?

    invalid_changeset = User.changeset(%User{}, %{
      name: "Leonardo",
      password: "abcdef"
    })
    refute invalid_changeset.valid?

    invalid_changeset = User.changeset(%User{}, %{
      name: "Leonardo",
      username: "abcbsjaisjdiajds",
    })
    refute invalid_changeset.valid?
  end

  test "valid user data should return a valid changeset" do
    valid_changeset = User.changeset(%User{}, %{
      name: "Leonardo",
      username: "lhiqwjalskeirjdksnam", # 20 characters
      password: "abcdef"
    })
    assert valid_changeset.valid?

    valid_changeset = User.changeset(%User{}, %{
      name: "Leonardo",
      username: "lhi", # 3 characters
      password: "abcdef"
    })
    assert valid_changeset.valid?

    valid_changeset = User.changeset(%User{}, %{
      username: "lhi", # 3 characters
      password: "abcdef"
    })
    assert valid_changeset.valid?
  end
end
