defmodule SoccerTest do
  use Soccer.DataCase

  describe "get_team_by_slug/1" do
    test "returns a team by slug" do
      team = insert(:team)
      assert {:ok, ^team} = Soccer.get_team_by_slug(team.slug)
    end

    test "accepts optional preloads" do
      team = insert(:team)
      player = insert(:player)
      insert(:player_team, player: player, team: team)

      assert {:ok, returned_team} =
               Soccer.get_team_by_slug(team.slug, preload: [:players])

      assert returned_team.players == [player]
    end

    test "returns an error if the team is not found" do
      assert {:error, :not_found} =
               Soccer.get_team_by_slug(Ecto.UUID.generate())
    end
  end

  describe "get_player_by_slug/1" do
    test "returns a player by slug" do
      player = insert(:player)
      assert {:ok, ^player} = Soccer.get_player_by_slug(player.slug)
    end

    test "accepts optional preloads" do
      team = insert(:team)
      player = insert(:player)
      insert(:player_team, player: player, team: team)

      assert {:ok, returned_player} =
               Soccer.get_player_by_slug(player.slug, preload: [:team])

      assert returned_player.team.slug == team.slug
    end

    test "returns an error if the player is not found" do
      assert {:error, :not_found} =
               Soccer.get_player_by_slug(Ecto.UUID.generate())
    end
  end

  describe "get_players_slugs_by_team_slug/1" do
    test "returns a list of player slugs by team slug" do
      team = insert(:team)
      player = insert(:player, team: team)
      insert(:player_team, player: player, team: team)

      assert {:ok, [returned_player_slug]} =
               Soccer.get_players_slugs_by_team_slug(team.slug)

      assert returned_player_slug == player.slug
    end

    test "returns an empty list if the team has no players" do
      team = insert(:team)
      assert {:ok, []} = Soccer.get_players_slugs_by_team_slug(team.slug)
    end
  end
end
