defmodule SoccerWeb.Queries.TeamQuery do
  @moduledoc """
  This module defines a query to fetch a team by its slug.
  """
  use SoccerWeb, :gql

  alias SoccerWeb.Resolvers.TeamResolver

  object :team_query do
    field :team, :team do
      arg :slug, non_null(:string)
      resolve &TeamResolver.get_team/3
    end
  end
end
