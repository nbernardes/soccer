defmodule SoccerWeb.Schema do
  @moduledoc """
  This module is used to define the GraphQL schema for the application.
  """
  use Absinthe.Schema

  alias SoccerWeb.Queries
  alias SoccerWeb.Types

  # Absinthe Custom Types
  import_types Absinthe.Type.Custom

  # GraphQL Queries
  import_types Queries.AppStatusQuery
  import_types Queries.SearchQuery

  # Ecto Schema -> GraphQL Types
  import_types Types.PlayerType
  import_types Types.TeamType

  query do
    import_fields :app_status_query
    import_fields :search_query
  end
end
