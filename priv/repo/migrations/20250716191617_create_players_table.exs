defmodule Soccer.Repo.Migrations.CreatePlayersTable do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :slug, :uuid, default: fragment("uuid_generate_v4()")
      add :name, :string, null: false
      add :age, :integer, null: false
      add :position, :string, null: false

      timestamps()
    end

    create unique_index(:players, [:slug])
    create index(:players, [:name])
  end
end
