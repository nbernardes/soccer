[
  import_deps: [:ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations"],
  plugins: [Styler, Phoenix.LiveView.HTMLFormatter],
  inputs: [
    "*.{heex,ex,exs}",
    "{config,lib,test}/**/*.{heex,ex,exs}",
    "priv/*/seeds.exs"
  ],
  line_length: 80,
  locals_without_parens: [
    # elixir
    defmodule: :*,
    defstruct: :*,
    send: :*,
    spawn: :*,

    # graphql
    import_fields: :*,
    import_types: :*,
    resolve: :*,
    resolve_type: :*,
    enum: :*,
    arg: :*,
    types: :*,
    union: :*
  ]
]
