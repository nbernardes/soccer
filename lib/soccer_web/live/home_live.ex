defmodule SoccerWeb.HomeLive do
  use SoccerWeb, :live_view

  alias Soccer.Player
  alias Soccer.Team

  def mount(params, _session, socket) do
    results =
      if String.trim(params["query"] || "") != "" do
        {:ok, results} = Soccer.search(params["query"], 10)
        results
      else
        []
      end

    socket
    |> assign(query: params["query"] || "", results: results)
    |> ok()
  end

  def handle_params(params, _url, socket) do
    socket
    |> assign(query: params["query"] || "")
    |> noreply()
  end

  def handle_event("search", %{"query" => search_query}, socket) do
    {:ok, results} = Soccer.search(search_query, 10)

    socket
    |> assign(results: results)
    |> push_patch(to: ~p"/?query=#{search_query}")
    |> noreply()
  end

  def handle_event(
        "select_result",
        %{"result_slug" => result_slug, "result_type" => result_type},
        socket
      ) do
    url =
      case result_type do
        "player" -> ~p"/players/#{result_slug}"
        "team" -> ~p"/teams/#{result_slug}"
      end

    socket
    |> push_navigate(to: url)
    |> noreply()
  end

  defp ok(socket), do: {:ok, socket}
  defp noreply(socket), do: {:noreply, socket}

  defp resolve_result_type(result) do
    case result do
      %Player{} -> :player
      %Team{} -> :team
    end
  end
end
