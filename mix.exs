defmodule Shorty.MixProject do
  use Mix.Project

  def project do
    [
      app: :shorty,
      version: "1.0.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
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
      mod: {Shorty.Application, []},
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
      {:ecto_sql, "~> 3.6"},
      {:ex_machina, "~> 2.7.0", only: [:dev, :test]},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:floki, ">= 0.30.0", only: :test},
      {:gettext, "~> 0.18"},
      {:hashids, github: "snaiper80/hashids-erlang", tag: "1.0.5"},
      {:jason, "~> 1.2"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.0"},
      # Using `master` branch because of https://github.com/phoenixframework/phoenix_live_reload/issues/113
      {:phoenix_live_reload,
       github: "phoenixframework/phoenix_live_reload", tag: "master", only: :dev},
      # Live view is installed, but only used for the new Phoenix 1.6 > heex
      # template engine. No part of LiveView was actually used. More info:
      # https://www.phoenixframework.org/blog/phoenix-1.6-released
      {:phoenix_live_view, "~> 0.16.0"},
      {:phoenix, "~> 1.6.0-rc.0", override: true},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd --cd assets npm ci"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["cmd --cd assets npm run build", "phx.digest"]
    ]
  end
end
