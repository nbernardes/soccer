defmodule Soccer.Dataloader do
  @moduledoc """
  Ecto-based source for a dataloader using the PostgreSQL database.

  Dataloader provides an easy way efficiently load data in batches. See [the
  `dataloader` documentation](https://hexdocs.pm/dataloader) for more info.

  This is used for field resolution.
  """
  # sobelow_skip ["SQL.Query"]
  def data do
    Dataloader.Ecto.new(Soccer.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
