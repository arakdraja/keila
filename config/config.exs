# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :keila,
  ecto_repos: [Keila.Repo]

# Configures the endpoint
config :keila, KeilaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ipC9dsQLUBKuLmcrKzqB3m1M/Sw/53FcA1xQd1yUKdTSqjlBqL729evTWqqwd6zT",
  render_errors: [view: KeilaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Keila.PubSub,
  live_view: [signing_salt: "kH+cT7XL"]

config :keila, Keila.Id,
  separator: "_",
  alphabet: "abcdefghijkmnopqrstuvwxyz23456789ABCDEFGHJKLMNPQRSTUVWXYZ_",
  salt: "bF4QzDjqV",
  min_len: 8

config :keila, Keila.Mailings.SenderAdapters,
  adapters: [
    Keila.Mailings.SenderAdapters.SMTP,
    Keila.Mailings.SenderAdapters.Sendgrid,
    Keila.Mailings.SenderAdapters.SES,
    Keila.Mailings.SenderAdapters.Mailgun
  ]

# Staging configuration for hCaptcha
config :keila, KeilaWeb.Hcaptcha,
  secret_key: "0x0000000000000000000000000000000000000000",
  site_key: "10000000-ffff-ffff-ffff-000000000001",
  url: "https://hcaptcha.com/siteverify"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :keila, Oban,
  queues: [
    mailer: [limit: 50, poll_interval: :timer.seconds(30)]
  ],
  repo: Keila.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
