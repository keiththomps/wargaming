defmodule WargamingTest.WarshipsTest do
  use ExUnit.Case, async: true
  use WargamingTest.Config

  doctest Wargaming.Warships
  alias Wargaming.Warships

  setup do
    reset_wargaming_config()
    :ok
  end

  describe "API URLs" do
    test "defaults the base URL to NA region" do
      url = Warships.process_url("/")
      assert url == "https://api.worldofwarships.com/wows/"
    end

    test "returns the EU region URL when configured for EU" do
      config_wargaming_with(region: "EU")
      url = Warships.process_url("/")
      assert url == "https://api.worldofwarships.eu/wows/"
    end

    test "returns the RU region URL when configured for RU" do
      Mix.Config.persist(wargaming: [region: "RU"])
      url = Warships.process_url("/")
      assert url == "https://api.worldofwarships.ru/wows/"
    end

    test "returns the ASIA region URL when configured for ASIA" do
      Mix.Config.persist(wargaming: [region: "ASIA"])
      url = Warships.process_url("/")
      assert url == "https://api.worldofwarships.asia/wows/"
    end
  end
end
