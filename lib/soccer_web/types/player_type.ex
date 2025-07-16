defmodule SoccerWeb.Types.PlayerType do
  @moduledoc """
  This module is used to define the Player GraphQL type.
  """
  use SoccerWeb, :gql

  alias Soccer.Player

  object :player do
    field :slug, non_null(:string)
    field :name, non_null(:string)
    field :age, non_null(:integer)
    field :position, non_null(:position_enum)
  end

  enum :position_enum, values: Player.positions()
end
