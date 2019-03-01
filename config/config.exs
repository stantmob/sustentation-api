# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sustentation,
  ecto_repos: [Sustentation.Repo]

# Configures the endpoint
config :sustentation, SustentationWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3pKGMBx1iskqOSGnwnMQwpph5PM3GINuO56S9o2izQFOptTa1Vb7Iuh/YkHEygWt",
  render_errors: [view: SustentationWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Sustentation.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :sustentation, Sustentation.Guardian,
  issuer: "sustentation",
  secret_key: "UffAcX9QJRIcUbYr9vxerrT+RHQPXdASMFEgU+UeczEu0cnFbBMI/qxDarYQrf+8"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
