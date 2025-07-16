defmodule Soccer.Services.SearchTest do
  use Soccer.DataCase

  alias Soccer.Services.Search

  describe "call/2" do
    test "returns a list of players and teams" do
      player = insert(:player, name: "Foo")
      team = insert(:team, name: "Foo Bar")

      assert {:ok, results} = Search.call("Foo", 10)

      assert length(results) == 2
      assert Enum.map(results, & &1.name) == [player.name, team.name]
    end

    test "filters out results that don't match the query" do
      player = insert(:player, name: "Foo")
      insert(:team, name: "Bar")

      assert {:ok, [result]} = Search.call("Foo", 10)
      assert result.name == player.name
    end

    test "returns an empty list when no results are found" do
      assert {:ok, results} = Search.call("Foo", 10)
      assert Enum.empty?(results)
    end

    test "fails when limit is greater than maximum search limit" do
      assert {:error, "Limit must be less than 50"} = Search.call("Foo", 51)
    end
  end
end
