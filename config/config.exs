# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :slackify,
  ecto_repos: [Slackify.Repo]

# Configures the endpoint
config :slackify, SlackifyWeb.Endpoint,
  url: [host: System.get_env("HOST"), port: 80],
  secret_key_base: "CCOo0YVNqusHSpdl92QyYW7rN3nuK/2B+gwdGdL63YL1+h8LrOR2FD5cCnUri1NE",
  render_errors: [view: SlackifyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Slackify.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :slackify, Slackify.Scheduler,
  jobs: [
    # Every minute
    {{:extended, "*/10 * * * *"}, {IO, :puts, ["hello"]}},
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
