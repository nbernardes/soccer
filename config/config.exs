import Config

config :esbuild,
  version: "0.17.11",
  soccer: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :soccer, Soccer.Mailer, adapter: Swoosh.Adapters.Local

config :soccer, SoccerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: SoccerWeb.ErrorHTML, json: SoccerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Soccer.PubSub,
  live_view: [signing_salt: "bi0lX62s"]

config :soccer,
  ecto_repos: [Soccer.Repo],
  generators: [timestamp_type: :utc_datetime],
  max_query_depth: 5

config :tailwind,
  version: "3.4.3",
  soccer: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

import_config "#{config_env()}.exs"
