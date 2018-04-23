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

  # Example Request /account/list/?application_id=#{APPLICATION_ID}&search=CallMeRabbi
  # Example using HTTPoison GET: Wargaming.Warships.get("/account/list/", [], params: %{application_id: app_id, search: "CallMeRabbi"})
end
