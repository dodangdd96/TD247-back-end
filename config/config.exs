# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :back_end,
  ecto_repos: [BackEnd.Repo]

# Configures the endpoint
config :back_end, BackEndWeb.Endpoint,
  url: [host: "localhost"],
  http: [port: 4000],
  secret_key_base: "c9TsgOoPN4VCjZwLRAfv5nNz5UWWhbE2Mv1laU0DqZas60mG7s8vw8GmlFHtjpwr",
  render_errors: [view: BackEndWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BackEnd.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :back_end, BackEnd.Guardian,
  issuer: "back_end",
  secret_key: "YO1yY3jBZxh4AAjz8WX/WwTRZBaiwJHEE+9LLv4t+nCJKBowbN3ge9aEixzptYTv"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
