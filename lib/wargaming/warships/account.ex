defmodule Wargaming.Warships.Account do
  @moduledoc """
  Account provides functions for interacting with the
  WarGaming.net World of Warships Account API.
  """

  use Wargaming.ApiEndpoint, api: Wargaming.Warships

  @account_list "/account/list/"
  @account_info "/account/info/"
  @account_achievements "/account/achievements/"
  @account_stats "/account/statsbydate/"

  @doc """
  Account.search/2 searches WarGaming accounts (in the configured region) and returns a list of matching nicknames with account IDs.

  [Official Reference](https://developers.wargaming.net/reference/all/wows/account/info/?application_id=123456&run=1)

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
  * `limit` : Number of entries to return. No more than 100, but fewer can be returned.
  * `type` : Search type. Default is "startswith". Available options:
    - "startswith" — Search by initial characters of name. Min-length: 3. Max-length: 24
    - "exact" - Search by exact (case-insensitive)
  """

  def search(names, opts \\ %{}) do
    constructed_get(:search, names, @account_list, opts)
  end

  @doc """
  Account.search/2 searches WarGaming accounts (in the configured region) based on a list of account_ids and returns detailed information.

  [Official Reference](https://developers.wargaming.net/reference/all/wows/account/info/?application_id=123456&r_realm=na)

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `access_token` : Token for accessing private data on account.
  * `extra` : Additional fields to return. See [Official Reference](https://developers.wargaming.net/reference/all/wows/account/info/?application_id=123456&r_realm=na) for more information.
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

  def by_id(account_ids, opts \\ %{}) do
    constructed_get(:account_id, account_ids, @account_info, opts)
  end

  @doc """
  Account.achievements/2 returns information about a players
  in-game achievements.

  [Official References](https://developers.wargaming.net/reference/all/wows/account/achievements/?application_id=123456&r_realm=na)

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `access_token` : Token for accessing private data on account.
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

  def achievements(account_ids, opts \\ %{}) do
    constructed_get(:account_id, account_ids, @account_achievements, opts)
  end

  @doc """
  Account.stats_for_dates/3 returns the stats for the given accounts in the given date or date range.

  [Official Reference](https://developers.wargaming.net/reference/all/wows/account/statsbydate/?application_id=123456&r_realm=na)

  Returns `{:ok, response_map}` or `{:error, error_map}`

  ## Available Options

  * `access_token` : Token for accessing private data on account.
  * `dates` : List of dates to return statistics for. Max date range of 28 days from the current date. Defaults to yesterday. Maximum number of days is 10.
  * `extra` : Additional fields to return. See [Official Reference](https://developers.wargaming.net/reference/all/wows/account/statsbydate/?application_id=123456&r_realm=na) for more information.
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

  def stats_for_dates(account_ids, dates, opts \\ %{}) do
    date_strings =
      dates
      |> Enum.map(fn date ->
        Date.to_iso8601(date, :basic)
      end)
      |> Enum.join(",")

    opts =
      opts
      |> Map.merge(%{dates: date_strings})

    constructed_get(:account_id, account_ids, @account_stats, opts)
  end

  @doc """
  See [stats_for_dates](#stats-for-dates). Returns default API value of yesterday.
  """
  def stats_for_yesterday(account_ids, opts \\ %{}) do
    constructed_get(:account_id, account_ids, @account_stats, opts)
  end
end
