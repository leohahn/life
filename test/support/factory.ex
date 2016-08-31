defmodule Life.Factory do
  use ExMachina.Ecto, repo: Life.Repo

  def user_factory do
    %Life.User{
      name: "Leonardo",
      username: "lhahn",
      password_hash: "abcdefg"
    }
  end

  def game_factory do
    %Life.Game{
      name: "My Game",
      state: [1,1,1,1,1,1,1,1,1],
      dimension: 3,
      user: build(:user)
    }
  end
end
