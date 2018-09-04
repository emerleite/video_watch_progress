use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :video_watch_progress, VideoWatchProgressWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :video_watch_progress, VideoWatchProgress.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "video_watch_progress_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
