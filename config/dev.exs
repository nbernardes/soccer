import Config

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :plug_init_mode, :runtime
config :phoenix, :stacktrace_depth, 20

config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true

config :soccer, Soccer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "soccer_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :soccer, SoccerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base:
    "BpfN2vPHvXD92pxyzWFMtb/oFZEbGyBIiyZsBJRDdCbaJSyo91Oj8T98ucoQscJ+",
  watchers: [
    esbuild:
      {Esbuild, :install_and_run, [:soccer, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:soccer, ~w(--watch)]}
  ]

config :soccer, SoccerWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/soccer_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :soccer, dev_routes: true

config :swoosh, :api_client, false
