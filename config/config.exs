# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :life,
  ecto_repos: [Life.Repo]

# Configures the endpoint
config :life, Life.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d9tU4vDtzLnJnv06YR+Uo2YJcrO7t7sB7PGVAxpKdoPjnLJvtdR1FNTjNd9DJFYz",
  render_errors: [view: Life.ErrorView, accepts: ~w(json)],
  pubsub: [name: Life.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Life",
  ttl: {30, :days},
  verify_issuer: true,
  secret_key: %{"k" => "toM-0--0GwbqDdu5Dtx3uQ", "kty" => "oct"},
  serializer: Life.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
