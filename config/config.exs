# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gpanel,
  ecto_repos: [GPanel.Repo],
  script_dir: "/Users/romanberg/project/gpanel"

# Configures the endpoint
config :gpanel, GPanelWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uRjyTMdLtdlgqUn7X2xc+ClnbBb98U+u12JrIcKk5CTeMz3VEf+AjSyBpHiNcfjW",
  render_errors: [view: GPanelWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GPanel.PubSub, adapter: Phoenix.PubSub.PG2]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
       providers: [
         identity_registration: {Ueberauth.Strategy.Identity, [
           param_nesting: "user",
           request_path: "/registration",
           callback_path: "/auth/identity/callback",
           callback_methods: ["POST"]
         ]},
         identity_login: {Ueberauth.Strategy.Identity, [
           param_nesting: "user",
           request_path: "/login",
           callback_path: "/auth/identity/callback",
           callback_methods: ["POST"]
         ]}
       ]

config :gpanel, GPanelWeb.Guardian,
       issuer: "gpanel",
       secret_key: "tRIEuU9IU4SelmHctkiHB0I1HyhZ72L4FXsXd0TZFSDLoQ1rMujzTTfwY7QyJ6SJ"

config :elidactyl, :pterodactyl_url, "localhost"
config :elidactyl, :pterodactyl_server_auth_token, "kts6G70izhPuTfmpt8FHry93FSet63OAJ9F8mwLGvfKqKJ5l"
config :elidactyl, :pterodactyl_client_auth_token, "SrMI9WWnS5Aq6OPQKHa4Pc5Q21YkVTohCyfjZVW2847XXdXj"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
