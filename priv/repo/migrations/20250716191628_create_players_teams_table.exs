defmodule Soccer.Repo.Migrations.CreatePlayersTeamsTable do
  use Ecto.Migration

  def change do
    create table(:players_teams, primary_key: false) do
      add :player_id, references(:players, on_delete: :delete_all), primary_key: true
      add :team_id, references(:teams, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create unique_index(:players_teams, [:player_id, :team_id])
  end
end
