# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :video_watch_progress,
  ecto_repos: [VideoWatchProgress.Repo]

# Configures the endpoint
config :video_watch_progress, VideoWatchProgressWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dCCP4/f/GzbGJ/IvMik7t8+A6nQQHiVbISey15v0us2+z0wE3QsxtEnww3F1GtQf",
  render_errors: [view: VideoWatchProgressWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: VideoWatchProgress.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :video_watch_progress, events_min_demand: 2
config :video_watch_progress, events_max_demand: 10

# in seconds
config :video_watch_progress, event_ttl: 11

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
