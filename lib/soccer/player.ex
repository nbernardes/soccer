defmodule Soccer.Player do
  @moduledoc """
  This module is used to define the Player model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: integer(),
          slug: Ecto.UUID.t(),
          name: String.t(),
          age: integer(),
          position: String.t()
        }

  @player_positions ~w(forward midfielder defender goalkeeper)a

  schema "players" do
    field :slug, Ecto.UUID
    field :name, :string
    field :age, :integer
    field :position, Ecto.Enum, values: @player_positions

    timestamps()
  end

  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :age, :position])
    |> validate_required([:name, :age, :position])
    |> unique_constraint(:slug)
  end

  def positions, do: @player_positions
end
