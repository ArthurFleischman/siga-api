# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :siga, SigaWeb.Guardian,
  issuer: "siga",
  secret_key: "O9Oeew3D4Fj505EZhBn+pCjmKjd2DxR/A/b6fEvoixf0ePqzMS6A3edOH4E0d/jo"

config :guardian, Guardian.DB,
  # Add your repository module
  repo: Siga.Repo,
  # default
  schema_name: "guardian_tokens",
  # store all token types if not set
  token_types: ["refresh_token", "access"],
  # default: 60 minutes
  sweep_interval: 60

config :siga,
  ecto_repos: [Siga.Repo],
  generators: [binary_id: true]

config :bcrypt_elixir, log_rounds: 4

config :siga,
  timezone: "America/Recife"

# Configures the endpoint
config :siga, SigaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OMD0nBU38CQ6DgXWIUq9tSuAS52FI1Dqd3cPe6lCTU9UAm/S0WAOw54guAbudycj",
  render_errors: [view: SigaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Siga.PubSub,
  live_view: [signing_salt: "0adQo4mJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
