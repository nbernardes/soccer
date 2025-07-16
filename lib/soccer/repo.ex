defmodule Soccer.Repo do
  use Ecto.Repo,
    otp_app: :soccer,
    adapter: Ecto.Adapters.Postgres
end
