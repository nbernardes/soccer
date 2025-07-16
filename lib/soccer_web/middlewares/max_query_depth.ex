defmodule SoccerWeb.Middleware.MaxQueryDepth do
  @moduledoc """
  Middleware that allows us to refuse queries that have a depth greater than a
  certain value.

  From Tomasz Tomczyk's blog post:
  https://tomasztomczyk.com/blog/2025/enforcing-max-query-depth-with-absinthe/
  """
  @behaviour Absinthe.Middleware

  require Logger

  def call(resolution, _config) do
    selection_depth = selection_depth(resolution.definition.selections)

    max_query_depth = max_query_depth()

    if selection_depth > max_query_depth do
      Absinthe.Resolution.put_result(
        resolution,
        {:error,
         %{
           code: :query_depth_limit,
           message:
             "Query has depth of #{selection_depth}, which exceeds max depth of #{max_query_depth}."
         }}
      )
    else
      resolution
    end
  end

  def selection_depth(fragments \\ [], selections \\ [], depth \\ 0)

  def selection_depth(_fragments, selections, depth) when selections == [],
    do: depth + 1

  def selection_depth(fragments, selections, depth) do
    selections
    |> Enum.map(fn selection ->
      case selection do
        %Absinthe.Blueprint.Document.Fragment.Spread{} = fragment ->
          selections =
            fragments
            |> Enum.find(fn {name, _} -> name == fragment.name end)
            |> elem(1)
            |> Map.get(:selections)

          selection_depth(fragments, selections, depth)

        field ->
          selection_depth(fragments, field.selections, depth + 1)
      end
    end)
    |> Enum.max()
  end

  defp max_query_depth, do: Application.get_env(:soccer, :max_query_depth)
end
