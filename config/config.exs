# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Ties.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_ties_key",
  session_secret: "&7I8GF_L#^O51UO%LEB7JL#EM9R&ST1+3X2TN#$%D(8D$&@I*P_060Z7)I==5C4R)_XEP5E((2N+J",
  catch_errors: true,
  debug_errors: false,
  error_controller: Ties.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
