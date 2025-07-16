defmodule Soccer.Scripts.SeedDatabase do
  @moduledoc """
  This module is used to seed the database.
  """
  require Logger

  alias Soccer.Player
  alias Soccer.PlayerTeam
  alias Soccer.Team
  alias Soccer.Repo

  @default_total_teams 1000
  @default_min_team_size 20

  def run(
        total_teams \\ @default_total_teams,
        min_team_size \\ @default_min_team_size
      ) do
    # Temporarily disable Ecto SQL debug logging to avoid spam
    original_level = Logger.level()
    Logger.configure(level: :info)

    Logger.info(
      "Seeding database with #{total_teams} teams and #{min_team_size} players per team",
      ansi_color: :yellow
    )

    # Since we're doing insert_all and we need to give the timestamps for every
    # element let's get the current timestamp and use it for all elements
    current_ts = NaiveDateTime.utc_now(:second)

    # Build and insert all teams at once
    teams = build_teams(total_teams, current_ts)
    {_, inserted_teams} = Repo.insert_all(Team, teams, returning: [:id])

    # Build and insert all players for each team
    # at once and respective team associations
    total_players =
      Enum.reduce(inserted_teams, 0, fn %{id: team_id}, acc ->
        total_team_players = :rand.uniform(5) + min_team_size
        players = build_players(total_team_players, current_ts)

        {_, inserted_players} =
          Repo.insert_all(Player, players, returning: [:id])

        players_teams =
          build_player_teams(inserted_players, team_id, current_ts)

        {_, _} = Repo.insert_all(PlayerTeam, players_teams)

        acc + length(inserted_players)
      end)

    Logger.info(
      "Database seeded successfully with #{total_teams} teams and #{total_players} players",
      ansi_color: :green
    )

    # Restore original Logger level
    Logger.configure(level: original_level)

    :ok
  end

  defp build_teams(total_teams, current_ts) do
    for _ <- 1..total_teams do
      %{
        name: build_team_name(),
        founded_at: Faker.Date.date_of_birth(),
        inserted_at: current_ts,
        updated_at: current_ts
      }
    end
  end

  defp build_players(total_team_players, current_ts) do
    for _ <- 1..total_team_players do
      %{
        name: build_player_name(),
        age: 15 + :rand.uniform(25),
        position: Enum.random(Ecto.Enum.values(Player, :position)),
        inserted_at: current_ts,
        updated_at: current_ts
      }
    end
  end

  defp build_player_teams(players, team_id, current_ts) do
    for player <- players do
      %{
        player_id: player.id,
        team_id: team_id,
        inserted_at: current_ts,
        updated_at: current_ts
      }
    end
  end

  defp build_team_name, do: "#{Faker.Company.name()} #{Faker.Team.name()}"

  defp build_player_name do
    first_name = Faker.Person.first_name()

    middle_names =
      0..:rand.uniform(3)
      |> Enum.map(fn _ -> Faker.Person.first_name() end)
      |> Enum.join(" ")

    last_name = Faker.Person.last_name()

    "#{first_name} #{middle_names} #{last_name}"
  end
end
