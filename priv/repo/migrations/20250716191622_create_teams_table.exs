defmodule Soccer.Repo.Migrations.CreateTeamsTable do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :slug, :uuid, default: fragment("uuid_generate_v4()")
      add :name, :string, null: false
      add :founded_at, :date, null: false

      timestamps()
    end

    create unique_index(:teams, [:slug])
    create unique_index(:teams, [:name])
  end
end
