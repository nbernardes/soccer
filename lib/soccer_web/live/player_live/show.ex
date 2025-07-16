defmodule SoccerWeb.PlayerLive.Show do
  @moduledoc false
  use SoccerWeb, :live_view

  def mount(%{"slug" => slug}, _session, socket) do
    {:ok, player} = Soccer.get_player_by_slug(slug, preload: [:team])
    {:ok, assign(socket, player: player)}
  end
end
