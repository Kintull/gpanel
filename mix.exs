defmodule GPanel.MixProject do
  use Mix.Project

  def project do
    [
      app: :gpanel,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {GPanel.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.7"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:comeonin, "~> 2.5"},
      {:arc_ecto, "~> 0.11.0"},
      {:phoenix_live_view, "~> 0.15.4"},
      {:floki, ">= 0.27.0", only: :test},
      {:ecto_psql_extras, "~> 0.2"},

      {:elidactyl, "~> 0.3.0"},
      {:poison, "~> 3.0"},
      {:gen_state_machine, "~> 2.0"},
      {:wallaby, "~> 0.25.0", runtime: false, only: :test},
      {:ueberauth, "~> 0.6"},
      {:ueberauth_identity, "~> 0.3.0"},
      {:guardian, "~> 2.1"},
      {:ex_machina, "~> 2.4", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["assets.compile --quiet", "ecto.create --quiet", "ecto.migrate", "test"],
      "assets.compile": &compile_assets/1
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd("./assets/node_modules/webpack/bin/webpack.js --mode development",
      quiet: true
    )
  end
end