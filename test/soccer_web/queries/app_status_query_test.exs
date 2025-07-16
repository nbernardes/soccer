defmodule SoccerWeb.Queries.AppStatusQueryTest do
  use SoccerWeb.ConnCase, async: true

  @ping_query """
  query {
    ping
  }
  """

  describe "ping" do
    test "returns pong", %{conn: conn} do
      expected_result = %{"data" => %{"ping" => "pong"}}

      result =
        conn
        |> post("/api", %{"query" => @ping_query})
        |> json_response(200)

      assert result == expected_result
    end
  end
end
