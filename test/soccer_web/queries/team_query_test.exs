defmodule SoccerWeb.Queries.TeamQueryTest do
  use SoccerWeb.ConnCase, async: true

  @team_query """
  query team($slug: String!) {
    team(slug: $slug) {
      slug
      playersSlugs
      players { slug }
    }
  }
  """

  describe "team/1" do
    test "returns a team by slug", %{conn: conn} do
      team = insert(:team)

      result =
        conn
        |> post("/api", %{query: @team_query, variables: %{slug: team.slug}})
        |> json_response(200)

      assert get_in(result, ["data", "team", "slug"]) == team.slug
    end

    test "properly resolves players slugs", %{conn: conn} do
      team = insert(:team)
      player = insert(:player, team: team)
      insert(:player_team, player: player, team: team)

      result =
        conn
        |> post("/api", %{query: @team_query, variables: %{slug: team.slug}})
        |> json_response(200)

      assert get_in(result, ["data", "team", "playersSlugs"]) == [player.slug]
    end

    test "properly resolves players", %{conn: conn} do
      team = insert(:team)
      player = insert(:player, team: team)
      insert(:player_team, player: player, team: team)

      result =
        conn
        |> post("/api", %{query: @team_query, variables: %{slug: team.slug}})
        |> json_response(200)

      assert get_in(result, ["data", "team", "players"]) == [
               %{"slug" => player.slug}
             ]
    end

    test "returns an error if the team is not found", %{conn: conn} do
      variables = %{slug: Ecto.UUID.generate()}

      %{"errors" => [error]} =
        conn
        |> post("/api", %{query: @team_query, variables: variables})
        |> json_response(200)

      assert error["message"] == "not_found"
    end
  end
end
