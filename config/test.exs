use Mix.Config

config :logger,
       backends: [:console],
       level: :info,
       utc_log: true,
       metadata: :all,
       format: "$time-$date [$level] $message {$metadata}\n"
