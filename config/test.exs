# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :wargaming, :app_id, System.get_env("APPLICATION_ID")
