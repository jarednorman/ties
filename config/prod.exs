use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Ties.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_ties_key",
  session_secret: "&7I8GF_L#^O51UO%LEB7JL#EM9R&ST1+3X2TN#$%D(8D$&@I*P_060Z7)I==5C4R)_XEP5E((2N+J"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

