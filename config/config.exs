# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :labrat,
  ecto_repos: [Labrat.Repo]

# Configures the endpoint
config :labrat, LabratWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ItZHH6JKs3HHrvab1Qagg6acPSGwkeMTaWkXYsyjU5WkaxrC5A3HQEYfpxxZw5o4",
  render_errors: [view: LabratWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Labrat.PubSub,
  live_view: [signing_salt: "qBqBZmAI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
