defmodule SoccerWeb.Resolvers.SearchResolver do
  @moduledoc """
  This module is used to define all resolvers related to the search query.
  """

  def search(_root, %{query: query, limit: limit}, _resolution) do
    Soccer.search(query, limit)
  end
end
