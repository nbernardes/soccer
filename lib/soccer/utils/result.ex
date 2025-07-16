defmodule Soccer.Result do
  @moduledoc """
  Utility functions for result tuples. We define result tuples as any tuple
  that starts with either `:ok` or `:error`.
  """

  @type t() :: {:ok, any()} | {:error, any()}
  @type t(value) :: {:ok, value} | {:error, any()}
  @type t(value, reason) :: {:ok, value} | {:error, reason}

  def ok_or({:ok, value}, _reason), do: {:ok, value}
  def ok_or(nil, reason), do: {:error, reason}
  def ok_or(term, _reason), do: {:ok, term}

  def ok_or_not_found(term), do: ok_or(term, :not_found)
end
