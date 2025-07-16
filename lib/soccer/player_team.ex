defmodule Soccer.PlayerTeam do
  @moduledoc """
  This module is used to define the PlayerTeam model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Soccer.Player
  alias Soccer.Team

  @type t :: %__MODULE__{
          player: Player.t(),
          team: Team.t()
        }

  @primary_key false
  schema "players_teams" do
    belongs_to :player, Player, primary_key: true
    belongs_to :team, Team, primary_key: true

    timestamps()
  end

  def changeset(player_team, attrs) do
    player_team
    |> cast(attrs, [:player_id, :team_id])
    |> validate_required([:player_id, :team_id])
    |> unique_constraint([:player_id, :team_id])
  end
end
