# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hello_domains,
  ecto_repos: [HelloDomains.Repo]

# Configures the endpoint
config :hello_domains, HelloDomains.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WspK8Q1Oe0v36smMcmJmE23eqLsuBwVLZQ8NdNzBOJPCZMB/9mmZ3MifFLmn8bGO",
  render_errors: [view: HelloDomains.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HelloDomains.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the DNSimple environment to target
config :hello_domains,
  dnsimple_client_base_url: "https://api.sandbox.dnsimple.com"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
