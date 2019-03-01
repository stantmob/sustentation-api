use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sustentation, SustentationWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sustentation, Sustentation.Repo,
  username: "stant",
  password: "stant",
  database: "sustentation_test",
  hostname: "172.20.20.189",
  pool: Ecto.Adapters.SQL.Sandbox
