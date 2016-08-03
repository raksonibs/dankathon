# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :backend,
  ecto_repos: [Backend.Repo]

# Configures the endpoint
config :backend, Backend.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5eKEfnUjKGDupeXHWg+3VX4942OzgU7lfQU8PrAkiNGC+ZPvvC0SO7dwA9XjmCcQ",
  render_errors: [view: Backend.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Backend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,  
  "json-api": Poison

  config :plug, :mimes, %{
    "application/vnd.api+json" => ["json-api"]
  }

config :arc,
  bucket: "dankathon"

config :ex_aws,
  access_key_id: [{:system, "AKIAIDNG2ASSNAZQH5LQ"}, :instance_role],
  secret_access_key: [{:system, "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"}, :instance_role]
  
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
