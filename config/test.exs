use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gpanel, GPanelWeb.Endpoint,
  http: [port: 4012],
  server: true

config :gpanel, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gpanel, GPanel.Repo,
  username: "postgres",
  password: "postgres",
  database: "gpanel_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox