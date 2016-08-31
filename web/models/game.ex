defmodule Life.Game do
  use Life.Web, :model

  @all_fields [:name, :state, :dimension]
  @required_fields [:name, :state, :dimension]

  schema "games" do
    field :name, :string
    field :state, {:array, :integer}
    field :dimension, :integer
    belongs_to :user, Life.User

    timestamps()
  end

  def changeset(struct, params \\ []) do
    struct
    |> cast(params, @all_fields)
    |> validate_required(@required_fields)
    |> validate_dimension_with_state()
  end

  defp validate_dimension_with_state(changeset) do
    if changeset.valid? do
      dimension = get_field(changeset, :dimension)
      state = get_field(changeset, :state)
      if :math.pow(dimension, 2) == Enum.count(state) do
        changeset
      else
        add_error(changeset, :dimension, "Does not match with state size.")
      end
    else
      changeset
    end
  end

end
