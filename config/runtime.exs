import Config

if config_env() == :prod do
  config :shorty,
    hash_id_salt: System.get_env("HASH_ID_SALT", "shorty url shortener")

  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      Please enter a valid connection string to a PostgreSQL database.
      """

  config :shorty, Shorty.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  host =
    System.get_env("HOST") ||
      raise """
      environment variable HOST is missing.
      Please set this variable to the domain people access shorty from.
      """

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      Please generate a 64 character random string.
      """

  config :shorty, ShortyWeb.Endpoint,
    url: [host: host],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: 8080
    ],
    secret_key_base: secret_key_base

  config :shorty, ShortyWeb.Endpoint, server: true
end
