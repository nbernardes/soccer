import Config

config :logger, level: :info

config :soccer, SoccerWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json"

config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Soccer.Finch
config :swoosh, local: false
