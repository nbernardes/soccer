defmodule SoccerWeb.Resolvers.AppStatusResolver do
  @moduledoc """
  This module is used to define all resolvers related to the app status.
  """

  def ping(_root, _args, _resolution) do
    {:ok, "pong"}
  end
end
