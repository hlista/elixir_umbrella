import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :authentication_service, AuthenticationService.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "authentication_service_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :authentication_web, AuthenticationWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "A1Cq0fPVBYxgoa8/cz0lOykVRAbfN/kwjdZ9xBZsz8n1G+EXU5lxiCscJEM9Q1db",
  server: false

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :oban_service, ObanService.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "oban_service_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2
