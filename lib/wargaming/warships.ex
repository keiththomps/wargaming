defmodule Wargaming.Warships do
  @moduledoc false

  # Wargaming.Warships is the base API module that configures the
  # root API to interact with for World of Warships for the given region.

  use HTTPoison.Base

  @endpoints %{
    "NA" => "https://api.worldofwarships.com/wows",
    "RU" => "https://api.worldofwarships.ru/wows",
    "EU" => "https://api.worldofwarships.eu/wows",
    "ASIA" => "https://api.worldofwarships.asia/wows"
  }

  @doc false
  def process_url(url) do
    region =
      case Application.fetch_env(:wargaming, :region) do
        :error -> "NA"
        {:ok, nil} -> "NA"
        {:ok, value} -> String.upcase(value)
      end

    @endpoints[region] <> url
  end
end
