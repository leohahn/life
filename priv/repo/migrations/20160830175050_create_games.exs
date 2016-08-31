defmodule Life.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name,      :string,            null: false
      add :state,     {:array, :integer}, null: false
      add :dimension, :integer,           null: false
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:games, [:name])
    create index(:games, [:user_id])
  end
end
