use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_domains, HelloDomains.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :hello_domains, HelloDomains.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "hello_domains_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :hello_domains,
  dnsimple_client_id: "dnsimple-client-id",
  dnsimple_client_secret: "dnsimple-client-secret",
  dnsimple_oauth_service: HelloDomains.Dnsimple.OauthMock,
  dnsimple_identity_service: HelloDomains.Dnsimple.IdentityMock,
  dnsimple_domains_service: HelloDomains.Dnsimple.DomainsMock
