# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :eased_backend,
  ecto_repos: [EasedBackend.Repo]

# Configures the endpoint
config :eased_backend, EasedBackend.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kmkCt9IdWcb+d8qjbsnGBdjGk39baLIkS7ZfONp7/BrTpMfMeUdqdTf4nQUiUaXm",
  render_errors: [view: EasedBackend.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EasedBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
