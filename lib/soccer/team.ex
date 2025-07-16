defmodule Soccer.Team do
  @moduledoc """
  This module is used to define the Team model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "teams" do
    field :slug, Ecto.UUID
    field :name, :string
    field :founded_at, :date

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
