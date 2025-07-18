defmodule Soccer.Team do
  @moduledoc """
  This module is used to define the Team model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Soccer.PlayerTeam

  @type t :: %__MODULE__{
          id: integer(),
          slug: Ecto.UUID.t(),
          name: String.t(),
          founded_at: Date.t()
        }

  schema "teams" do
    field :slug, Ecto.UUID
    field :name, :string
    field :founded_at, :date

    has_many :player_teams, PlayerTeam
    has_many :players, through: [:player_teams, :player]

    timestamps()
  end

  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :founded_at])
    |> validate_required([:name, :founded_at])
    |> unique_constraint(:slug)
    |> unique_constraint(:name)
  end
end
