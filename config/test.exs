import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :shorty, Shorty.Repo,
  username: "postgres",
  password: "postgres",
  database: "shorty_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("DB_HOST", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shorty, ShortyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
