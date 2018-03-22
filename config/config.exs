# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :oauth2_server, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:oauth2_server, :key)
#
# Or configure a 3rd-party app:

config :oauth2_server, :logger,
  backends: [:console],
  level: :info,
  utc_log: true,
  format: "$time-$date [$level] $message {$metadata}\n"

config :oauth2_server, :registration,
  homepage_link: "https://www.oauth.com",
  company_logo: "logo.png",
  oauth_logo: "logo.png",
  title: "Oauth 2.0 Application Registration",
  oauth_desc: "The OAuth 2.0 authorization framework enables a third-party
   application to obtain limited access to an HTTP service, either on
   behalf of a resource owner by orchestrating an approval interaction
   between the resource owner and the HTTP service, or by allowing the
   third-party application to obtain access on its own behalf."

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
import_config "#{Mix.env}.exs"
