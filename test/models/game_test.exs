defmodule Life.GameTest do
  use Life.ConnCase
  use Life.Web, :model

  alias Life.Game

  test "changeset requires name, state and dimension" do
    valid_changeset = Game.changeset(
      %Game{}, %{"name" => "sonic",
                 "state" => [1,2,3,4,5,6,7,8,1],
                 "dimension" => 3}
    )
    assert valid_changeset.valid?

    invalid_changeset = Game.changeset(
      %Game{}, %{"state" => [1,2,3,4,5,6,7,8,1],
                 "dimension" => 3}
    )
    refute invalid_changeset.valid?

    invalid_changeset = Game.changeset(
      %Game{}, %{"name" => "sonic",
                 "dimension" => 3}
    )
    refute invalid_changeset.valid?

    invalid_changeset = Game.changeset(
      %Game{}, %{"name" => "sonic",
                 "state" => [1,2,3,4,5,6,7,8,1]}
    )
    refute invalid_changeset.valid?
  end

  test "changeset requires state length to be dimension squared" do
    valid_changeset = Game.changeset(
      %Game{}, %{"name" => "sonic",
                 "state" => [1,2,3,4,5,6,7,8,1],
                 "dimension" => 3}
    )
    assert valid_changeset.valid?

    invalid_changeset = Game.changeset(
      %Game{}, %{"name" => "sonic",
                 "state" => [1,2,3,5,6,7,8,1],
                 "dimension" => 3}
    )
    refute invalid_changeset.valid?
  end
end
