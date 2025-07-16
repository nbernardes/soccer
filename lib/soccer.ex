defmodule Soccer do
  @moduledoc """
  Since this is a simple app, we don't need to define any
  additional contexts, so we'll just use this default one for all
  logic associated with the app.
  """
  import Ecto.Query

  alias Soccer.Player
  alias Soccer.Repo
  alias Soccer.Result
  alias Soccer.Services
  alias Soccer.Team

  @spec search(String.t(), integer()) :: Result.t([Player.t() | Team.t()])
  defdelegate search(search_query, limit), to: Services.Search, as: :call

  @spec get_team_by_slug(String.t()) :: Result.t(Team.t())
  def get_team_by_slug(slug) do
    Repo.get_by(Team, slug: slug)
    |> Result.ok_or_not_found()
  end

  @spec get_players_slugs_by_team_slug(String.t()) :: Result.t([String.t()])
  def get_players_slugs_by_team_slug(slug) do
    players_slugs =
      Player
      |> join(:inner, [p], t in assoc(p, :team), as: :t)
      |> where([t: t], t.slug == ^slug)
      |> select([p], p.slug)
      |> Repo.all()

    {:ok, players_slugs}
  end
end
