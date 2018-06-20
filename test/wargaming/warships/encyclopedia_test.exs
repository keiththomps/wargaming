defmodule WargamingTest.Warships.EncyclopediaTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use WargamingTest.Config

  alias Wargaming.Warships.Encyclopedia

  @example_ship_id "3337500656"

  setup do
    config_wargaming_with(region: "NA")
    :ok
  end

  describe "Encyclopedia.info/1" do
    test "returns the all encyclopedia information" do
      use_cassette "warship_encyclopedia_info" do
        {:ok, info} = Encyclopedia.info()

        assert 4 = length(Map.keys(info[:data][:ship_types]))
      end
    end
  end

  describe "Encyclopedia.ships/1" do
    test "returns the ships information" do
      use_cassette "warship_encyclopedia_ships" do
        {:ok, ships} = Encyclopedia.ships(%{type: "AirCarrier,Cruiser"})

        assert 2 = ships[:meta][:page_total]
      end
    end
  end

  describe "Encyclopedia.achievements/1" do
    test "returns the achievment information" do
      use_cassette "warship_encyclopedia_achievements" do
        {:ok, achievements} = Encyclopedia.achievements()

        assert 165 = length(Map.keys(achievements[:data][:battle]))
      end
    end
  end

  describe "Encyclopedia.ship_parameters/2" do
    test "returns the ship configuration parameters given a valid ship ID" do
      use_cassette "warship_encyclopedia_ship_parameters" do
        {:ok, parameters} = Encyclopedia.ship_parameters(@example_ship_id)

        assert 36.0 = parameters[:data][String.to_atom(@example_ship_id)][:engine][:max_speed]
      end
    end
  end
end
