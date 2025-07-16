defmodule SoccerWeb.Queries.AppStatusQuery do
  @moduledoc """
  This module is used to define all queries related to the app status.
  """
  use SoccerWeb, :gql

  alias SoccerWeb.Resolvers.AppStatusResolver

  object :app_status_query do
    field :ping, :string do
      resolve &AppStatusResolver.ping/3
    end
  end
end
