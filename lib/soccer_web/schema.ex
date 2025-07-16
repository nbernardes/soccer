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
  import_types Queries.TeamQuery

  # Ecto Schema -> GraphQL Types
  import_types Types.PlayerType
  import_types Types.TeamType

  query do
    import_fields :app_status_query
    import_fields :search_query
    import_fields :team_query
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(
        Soccer.Dataloader,
        Soccer.Dataloader.data()
      )

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, _object) do
    middleware ++ [SoccerWeb.Middleware.MaxQueryDepth]
  end
end
