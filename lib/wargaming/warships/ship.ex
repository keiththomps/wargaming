defmodule Wargaming.Warships.Ship do
  @moduledoc """
  Ship provides functions for interacting with the
  WarGaming.net World of Warships Warships API.
  """

  use Wargaming.ApiEndpoint, api: Wargaming.Warships

  @ship_stats "/ships/stats/"

  @doc """
  Ship.stats_for_all_ships/2 searches WarGaming ship stats (in the configured region) and returns all ship statistics for the given account id.

  [Official Reference](https://developers.wargaming.net/reference/all/wows/ships/stats/?application_id=123456&r_realm=na)

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `access_token` : Token for accessing private data on account.
  * `extra` : Additional fields to add to the response. See [Official Reference](https://developers.wargaming.net/reference/all/wows/ships/stats/?application_id=123456&r_realm=na) for more information.
  * `fields` : Comma separated list of fields. Embedded fields separated by periods. To exclude a field, prefix it with a `-`. Returns all fields if one of the fields is undefined.
  * `in_garage` : Filter by ship's availability in the port. If not specified, all ships are returned. Available options (options are strings):
    - "1" — Available in port.
    - "0" — Ship not in port.
  * `language` : Default "en". Available options:
    - "cs" — Čeština
    - "de" — Deutsch
    - "en" — English (by default)
    - "es" — Español
    - "fr" — Français
    - "ja" — 日本語
    - "pl" — Polski
    - "ru" — Русский
    - "th" — ไทย
    - "zh-tw" — 繁體中文
  * `ship_id` : Ship id(s). Max limit of 100.
  """
  def stats_for_all_ships(account_id, opts \\ %{}) do
    constructed_get(:account_id, account_id, @ship_stats, opts)
  end

  @doc """
  See [Ship.stats_for_all_ships/2](#stats_for_all_ships/2). Convenience function for specifying specific ship(s).
  """
  def stats_for_ship(accounts_id, ship_ids, opts \\ %{})

  def stats_for_ship(account_id, ship_ids, opts) when is_list(ship_ids) do
    opts =
      opts
      |> Map.merge(%{ship_id: Enum.join(ship_ids, ",")})

    stats_for_all_ships(account_id, opts)
  end

  def stats_for_ship(account_id, ship_id, opts) do
    opts =
      opts
      |> Map.merge(%{ship_id: ship_id})

    stats_for_all_ships(account_id, opts)
  end
end
