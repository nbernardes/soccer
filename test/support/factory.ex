defmodule Soccer.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Soccer.Repo

  alias Soccer.Player
  alias Soccer.PlayerTeam
  alias Soccer.Team

  def player_factory do
    %Player{
      slug: Ecto.UUID.generate(),
      name: Faker.Person.name(),
      age: 15 + :rand.uniform(25),
      position: Enum.random(Player.positions())
    }
  end

  def team_factory do
    %Team{
      slug: Ecto.UUID.generate(),
      name: Faker.Team.name(),
      founded_at: Faker.Date.date_of_birth()
    }
  end

  def player_team_factory do
    %PlayerTeam{
      player: build(:player),
      team: build(:team)
    }
  end
end
