use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :back_end, BackEndWeb.Endpoint,
  secret_key_base: "2TTrw3rSeGA9v8jjzj7dAAbkMXj+upQ8ZxUrtw6EHeFSP3HNhRqQo9TGR0mF93OH"

# Configure your database
config :back_end, BackEnd.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "back_end_prod",
  pool_size: 15
