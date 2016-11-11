# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :br,
  ecto_repos: [Br.Repo]

# Configures the endpoint
config :br, Br.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PkaIcQ02onc5bsoPt+AF1v/2nhgRqyKuFqaiNWXxN6pir/XdlvbnPbo7lq7+tlw6",
  render_errors: [view: Br.ErrorView, accepts: ~w(json)],
  pubsub: [name: Br.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
