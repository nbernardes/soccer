defmodule SoccerWeb.Queries.SearchQueryTest do
  use SoccerWeb.ConnCase, async: true

  @search_query """
  query search($query: String!, $limit: Int) {
    search(query: $query, limit: $limit) {
      ... on Player {
        __typename
        slug
      }
      ... on Team {
        __typename
        slug
      }
    }
  }
  """

  describe "search" do
    test "returns a list of players and teams", %{conn: conn} do
      player = insert(:player, name: "Foo")
      team = insert(:team, name: "Foo Bar")
      variables = %{query: "Foo"}

      result =
        conn
        |> post("/api", %{"query" => @search_query, "variables" => variables})
        |> json_response(200)

      assert result == %{
               "data" => %{
                 "search" => [
                   %{"__typename" => "Player", "slug" => player.slug},
                   %{"__typename" => "Team", "slug" => team.slug}
                 ]
               }
             }
    end

    test "filters out results that don't match the query", %{conn: conn} do
      player = insert(:player, name: "Foo")
      insert(:team, name: "Bar")
      variables = %{query: "Foo"}

      result =
        conn
        |> post("/api", %{"query" => @search_query, "variables" => variables})
        |> json_response(200)

      assert result == %{
               "data" => %{
                 "search" => [
                   %{"__typename" => "Player", "slug" => player.slug}
                 ]
               }
             }
    end

    test "returns an empty list when no results are found", %{conn: conn} do
      variables = %{query: "Foo"}

      result =
        conn
        |> post("/api", %{"query" => @search_query, "variables" => variables})
        |> json_response(200)

      assert Enum.empty?(get_in(result, ["data", "search"]))
    end

    test "returns an error when limit is greater than 50", %{conn: conn} do
      variables = %{query: "Foo", limit: 51}

      %{"errors" => [error]} =
        conn
        |> post("/api", %{"query" => @search_query, "variables" => variables})
        |> json_response(200)

      assert error["message"] == "Limit must be less than 50"
    end
  end
end
