use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :life, Life.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :life, Life.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "life_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Set the rounds on the hashing algorithm to a lower amount.
# This is helpful during test, since it makes them run faster.
config :comeonin, bcrypt_log_rounds: 4
