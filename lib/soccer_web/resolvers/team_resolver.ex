defmodule SoccerWeb.Resolvers.TeamResolver do
  @moduledoc """
  This module is used to define all resolvers related to the team query
  and the team type fields.
  """

  alias Soccer.Team

  def get_team(_root, %{slug: slug}, _resolution) do
    Soccer.get_team_by_slug(slug)
  end

  #
  # Field resolutions
  #

  def get_players_slugs(%Team{slug: slug}, _args, _resolution) do
    Soccer.get_players_slugs_by_team_slug(slug)
  end
end
