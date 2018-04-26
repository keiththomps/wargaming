defmodule WargamingTest.Warships.ShipTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use WargamingTest.Config

  alias Wargaming.Warships.Ship

  @example_id 1_030_494_954
  @example_id_atom @example_id |> Integer.to_string() |> String.to_atom()

  @example_ship_id 4_289_640_432
  @second_ship_id 3_555_670_000

  setup do
    config_wargaming_with(region: "NA")
    :ok
  end

  describe "Ship.stats_for_all_ships/2" do
    test "returns the all ship statistics for a given account id" do
      use_cassette "warship_ship_stats_all" do
        {:ok, stats} = Ship.stats_for_all_ships(@example_id)

        assert 20 = length(stats[:data][@example_id_atom])
      end
    end
  end

  describe "Ship.stats_for_ship/3" do
    test "returns the ship statistics for a given ship and account id" do
      use_cassette "warship_ship_stats_single" do
        {:ok, stats} = Ship.stats_for_ship(@example_id, @example_ship_id)

        assert 1 = length(stats[:data][@example_id_atom])
        assert @example_ship_id = List.first(stats[:data][@example_id_atom])[:ship_id]
      end
    end
  end

  describe "Ship.stats_for_ship/3 with multiple ships" do
    test "returns the ship statistics for a given ships and account id" do
      use_cassette "warship_ship_stats_multiple_ships" do
        {:ok, stats} = Ship.stats_for_ship(@example_id, [@example_ship_id, @second_ship_id])

        assert 2 = length(stats[:data][@example_id_atom])
        assert @example_ship_id = List.first(stats[:data][@example_id_atom])[:ship_id]
        assert @second_ship_id = List.last(stats[:data][@example_id_atom])[:ship_id]
      end
    end
  end
end
