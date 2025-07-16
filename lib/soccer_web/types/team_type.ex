defmodule SoccerWeb.Types.TeamType do
  @moduledoc """
  This module is used to define the Team GraphQL type.
  """
  use SoccerWeb, :gql

  object :team do
    field :slug, non_null(:string)
    field :name, non_null(:string)
    field :founded_at, non_null(:date)
  end
end
