defmodule Soccer.Services.Search do
  @moduledoc """
  Global search service. It will search results on both player and team tables.
  """
  import Ecto.Query

  alias Soccer.Player
  alias Soccer.Repo
  alias Soccer.Team

  @max_search_limit 50

  @spec call(String.t(), integer()) ::
          {:ok, [Player.t() | Team.t()]} | {:error, String.t()}
  def call(search_query, limit) when limit <= @max_search_limit do
    search_term = "%#{search_query}%"

    # We could make use of `with` or `union` as it's supported by Postgres, but
    # using those solutions would require to return the same fields for both
    # players and teams, removing the ability to use the direct structs for each
    # schema. To make the queries more performant, we'll run both queries in
    # parallel.
    {players_task, teams_task} = {
      Task.async(fn ->
        list_players(search_term, limit)
      end),
      Task.async(fn ->
        list_teams(search_term, limit)
      end)
    }

    players = Task.await(players_task)
    teams = Task.await(teams_task)

    # Combine and sort results
    results =
      (players ++ teams)
      |> Enum.sort_by(& &1.name, :asc)
      |> Enum.take(limit)

    {:ok, results}
  end

  def call(_search_query, _limit) do
    {:error, "Limit must be less than #{@max_search_limit}"}
  end

  defp list_players(search_term, limit) do
    Player
    |> where([p], ilike(p.name, ^search_term))
    |> limit(^limit)
    |> Repo.all()
  end

  defp list_teams(search_term, limit) do
    Team
    |> where([t], ilike(t.name, ^search_term))
    |> limit(^limit)
    |> Repo.all()
  end
end
