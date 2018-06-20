defmodule Wargaming.Warships.Encyclopedia do
  @moduledoc """
  Encyclopedia provides functions for interacting with the WarGaming.net World of Warships Encyclopedia API.
  """

  use Wargaming.ApiEndpoint, api: Wargaming.Warships

  @encyclopedia_info "/encyclopedia/info/"
  @encyclopedia_ships "/encyclopedia/ships/"
  @encyclopedia_achievements "/encyclopedia/achievements/"
  @encyclopedia_ship_parameters "/encyclopedia/shipprofile/"

  @doc """
  Encyclopedia.info/1 searches WarGaming Warships Encyclopedia (in the configured region) and returns general enclopedia info.

  [Official Reference](https://api.worldofwarships.com/wows/encyclopedia/info/?application_id=123456

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `fields` : Comma separated list of fields. Embedded fields separated by periods. To exclude a field, prefix it with a `-`. Returns all fields if one of the fields is undefined.
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
  """
  def info(opts \\ %{}) do
    constructed_get(@encyclopedia_info, opts)
  end

  @doc """
  Encyclopedia.ships/1 searches WarGaming Warships Encyclopedia (in the configured region) and returns ship info.

  [Official Reference](https://api.worldofwarships.com/wows/encyclopedia/ships/?application_id=123456

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `fields` : Comma separated list of fields. Embedded fields separated by periods. To exclude a field, prefix it with a `-`. Returns all fields if one of the fields is undefined.
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
  * `limit` : Number of returned entries (fewer can be returned, but not more than 100). If the limit sent exceeds 100, a limit of 100 is applied (by default).
  * `nation` : Comma separated list of nations. Max limit is 100.
  * `page_no` : Result page number. Default is 1. Min value is 1.
  * `ship_id` : Comma separated list of ship IDs. Max limit is 100.
  * `type` : Comma separated list of ship types. Max limit is 100. Valid values:
    - "AirCarrier" — Aircraft carrier
    - "Battleship" — Battleship
    - "Destroyer" — Destroyer
    - "Cruiser" — Cruiser
  """
  def ships(opts \\ %{}) do
    constructed_get(@encyclopedia_ships, opts)
  end

  @doc """
  Encyclopedia.achievements/1 searches WarGaming Warships Encyclopedia (in the configured region) and returns achievement info.

  [Official Reference](https://api.worldofwarships.com/wows/encyclopedia/achievements/?application_id=123456

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `fields` : Comma separated list of fields. Embedded fields separated by periods. To exclude a field, prefix it with a `-`. Returns all fields if one of the fields is undefined.
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
  """
  def achievements(opts \\ %{}) do
    constructed_get(@encyclopedia_achievements, opts)
  end

  @doc """
  Encyclopedia.ship_parameters/2 searches WarGaming Warships Encyclopedia (in the configured region) and returns ship configuration options info.

  [Official Reference](https://api.worldofwarships.com/wows/encyclopedia/achievements/?application_id=123456

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `fields` : Comma separated list of fields. Embedded fields separated by periods. To exclude a field, prefix it with a `-`. Returns all fields if one of the fields is undefined.
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
  """
  def ship_parameters(ship_id, opts \\ %{}) do
    constructed_get(:ship_id, ship_id, @encyclopedia_ship_parameters, opts)
  end
end
