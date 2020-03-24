# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gpanel,
  ecto_repos: [Gpanel.Repo],
  script_dir: "/Users/romanberg/project/gpanel"

# Configures the endpoint
config :gpanel, GpanelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uRjyTMdLtdlgqUn7X2xc+ClnbBb98U+u12JrIcKk5CTeMz3VEf+AjSyBpHiNcfjW",
  render_errors: [view: GpanelWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Gpanel.PubSub, adapter: Phoenix.PubSub.PG2]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"