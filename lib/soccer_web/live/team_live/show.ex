defmodule SoccerWeb.TeamLive.Show do
  use SoccerWeb, :live_view

  def mount(%{"slug" => slug}, _session, socket) do
    {:ok, team} = Soccer.get_team_by_slug(slug, preload: [:players])
    {:ok, assign(socket, team: team)}
  end
end
