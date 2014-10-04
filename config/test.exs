use Mix.Config

config :phoenix, Ties.Router,
  port: System.get_env("PORT") || 4001,
  ssl: false,
  cookies: true,
  session_key: "_ties_key",
  session_secret: "&7I8GF_L#^O51UO%LEB7JL#EM9R&ST1+3X2TN#$%D(8D$&@I*P_060Z7)I==5C4R)_XEP5E((2N+J"

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


