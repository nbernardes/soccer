import Config

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  enable_expensive_runtime_checks: true

config :soccer, Soccer.Mailer, adapter: Swoosh.Adapters.Test

config :soccer, Soccer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "soccer_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :soccer, SoccerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base:
    "TM4Wc5hF/8LQ8Ak8y9GOMuXQZyTQP3+npOgTu0YuHNxU2bH40fzD3GqEIS/10ubT",
  server: false

config :swoosh, :api_client, false
