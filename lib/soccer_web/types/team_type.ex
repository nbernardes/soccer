defmodule SoccerWeb.Types.TeamType do
  @moduledoc """
  This module is used to define the Team GraphQL type.
  """
  use SoccerWeb, :gql

  alias Absinthe.Resolution.Helpers, as: AbsintheHelpers
  alias Soccer.Dataloader
  alias SoccerWeb.Resolvers.TeamResolver

  object :team do
    field :slug, non_null(:string)
    field :name, non_null(:string)
    field :founded_at, non_null(:date)

    field :players_slugs, non_null(list_of(:string)) do
      resolve &TeamResolver.get_players_slugs/3
    end

    field :players, non_null(list_of(:player)) do
      resolve AbsintheHelpers.dataloader(Dataloader)
    end
  end
end
