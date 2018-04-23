defmodule Wargaming.Warships do
  use HTTPoison.Base

  @endpoints %{
    "NA" => "https://api.worldofwarships.com/wows",
    "RU" => "https://api.worldofwarships.ru/wows",
    "EU" => "https://api.worldofwarships.eu/wows",
    "ASIA" => "https://api.worldofwarships.asia/wows"
  }

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
