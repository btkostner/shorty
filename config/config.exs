# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :shorty,
  ecto_repos: [Shorty.Repo],
  hash_id_salt: "shorty url shortener"

# Configures the endpoint
config :shorty, ShortyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eYnkn0wUcvNdNQvvTW6cPei+QwLD0zppD4O8D0uBKuirj5ql4V6/HqKE+zYjATWf",
  render_errors: [view: ShortyWeb.ErrorView, accepts: ~w(html json), layout: "root.html"],
  pubsub_server: Shorty.PubSub

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
