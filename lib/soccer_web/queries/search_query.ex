defmodule SoccerWeb.Queries.SearchQuery do
  @moduledoc """
  This module defines a global search query that
  will search for both players and teams.
  """
  use SoccerWeb, :gql

  alias Soccer.Player
  alias Soccer.Team
  alias SoccerWeb.Resolvers.SearchResolver

  @default_search_limit 10

  object :search_query do
    field :search, list_of(:search_result) do
      arg :query, non_null(:string)
      arg :limit, :integer, default_value: @default_search_limit
      resolve &SearchResolver.search/3
    end
  end

  union :search_result do
    types [:player, :team]
    resolve_type &resolve_type/2
  end

  def resolve_type(%Player{}, _), do: :player
  def resolve_type(%Team{}, _), do: :team
end
