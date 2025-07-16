defmodule Soccer do
  @moduledoc """
  Since this is a simple app, we don't need to define any
  additional contexts, so we'll just use this default one for all
  logic associated with the app.
  """

  alias Soccer.Player
  alias Soccer.Services
  alias Soccer.Team

  @spec search(String.t(), integer()) ::
          {:ok, [Player.t() | Team.t()]} | {:error, String.t()}
  defdelegate search(search_query, limit), to: Services.Search, as: :call
end
