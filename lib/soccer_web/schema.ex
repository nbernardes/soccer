defmodule SoccerWeb.Schema do
  @moduledoc """
  This module is used to define the GraphQL schema for the application.
  """
  use Absinthe.Schema

  alias SoccerWeb.Queries

  import_types Queries.AppStatusQuery

  query do
    import_fields :app_status_query
  end
end
