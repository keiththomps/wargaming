defmodule WargamingTest.Warships.AccountTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use WargamingTest.Config

  alias Wargaming.Warships.Account

  @example_id 1_030_494_954
  @second_example_id 1_014_151_486

  setup do
    config_wargaming_with(region: "NA")
    :ok
  end

  describe "Account.search/2" do
    test "returns list of user nicknames and ids" do
      use_cassette "warship_account_search" do
        {:ok, search} = Account.search("CallMeR")

        assert 7 = search[:meta].count
        assert %{nickname: "CallMeRabbi", account_id: @example_id} = List.first(search[:data])
      end
    end

    test "utilizes additional options" do
      use_cassette "warship_account_search_limit" do
        {:ok, search} = Account.search("CallMeR", %{limit: 1})

        assert 1 = search[:meta].count
        assert %{nickname: "CallMeRabbi", account_id: @example_id} = List.first(search[:data])
      end
    end

    test "handles API errors" do
      use_cassette "warship_account_search_error" do
        {:error, error} = Account.search("")

        assert %{
                 code: 402,
                 field: "search",
                 message: "SEARCH_NOT_SPECIFIED",
                 value: ""
               } = error
      end
    end
  end

  describe "Account.by_id/2 with a list of account ids" do
    test "returns multiple accounts" do
      use_cassette "warship_account_by_id_multiple" do
        {:ok, result} = Account.by_id([@example_id, @second_example_id])

        assert 2 = result[:meta].count

        first_atom =
          @example_id
          |> Integer.to_string()
          |> String.to_atom()

        second_atom =
          @second_example_id
          |> Integer.to_string()
          |> String.to_atom()

        assert %{
                 ^first_atom => _,
                 ^second_atom => _
               } = result[:data]
      end
    end

    test "returns a single error if one of the ids is invalid" do
      use_cassette "warship_account_by_id_multiple_error" do
        {:error, error} = Account.by_id([@example_id, "fake_id"])

        assert %{
                 field: "account_id",
                 message: "INVALID_ACCOUNT_ID",
                 code: 407,
                 value: "fake_id"
               } = error
      end
    end
  end

  describe "Account.by_id/2 with a single account id" do
    test "returns the accounts" do
      use_cassette "warship_account_by_id" do
        {:ok, result} = Account.by_id(@example_id)

        assert 1 = result[:meta].count

        first_atom =
          @example_id
          |> Integer.to_string()
          |> String.to_atom()

        assert %{^first_atom => _} = result[:data]
      end
    end

    test "returns a single error if one of the ids is invalid" do
      use_cassette "warship_account_by_id_with_error" do
        {:error, error} = Account.by_id("fake_id")

        assert %{
                 field: "account_id",
                 message: "INVALID_ACCOUNT_ID",
                 code: 407,
                 value: "fake_id"
               } = error
      end
    end
  end

  describe "Account.achievements/2 with a list of account ids" do
    test "returns multiple accounts' achievements" do
      use_cassette "warship_account_achievements_multiple" do
        {:ok, result} = Account.achievements([@example_id, @second_example_id])

        assert 2 = result[:meta].count

        first_atom =
          @example_id
          |> Integer.to_string()
          |> String.to_atom()

        second_atom =
          @second_example_id
          |> Integer.to_string()
          |> String.to_atom()

        assert %{
                 ^first_atom => _,
                 ^second_atom => _
               } = result[:data]
      end
    end

    test "returns a single error if one of the ids is invalid" do
      use_cassette "warship_account_achievements_multiple_error" do
        {:error, error} = Account.by_id([@example_id, "fake_id"])

        assert %{
                 field: "account_id",
                 message: "INVALID_ACCOUNT_ID",
                 code: 407,
                 value: "fake_id"
               } = error
      end
    end
  end

  describe "Account.achievements/2 with a single account id" do
    test "returns the account's achievements" do
      use_cassette "warship_account_achievements" do
        {:ok, result} = Account.achievements(@example_id)

        assert 1 = result[:meta].count

        first_atom =
          @example_id
          |> Integer.to_string()
          |> String.to_atom()

        assert %{^first_atom => _} = result[:data]
      end
    end

    test "returns a single error if one of the ids is invalid" do
      use_cassette "warship_account_achievements_with_error" do
        {:error, error} = Account.achievements("fake_id")

        assert %{
                 field: "account_id",
                 message: "INVALID_ACCOUNT_ID",
                 code: 407,
                 value: "fake_id"
               } = error
      end
    end
  end

  describe "Account.stats_for_yesterday/2 with a single account id" do
    test "returns the account's stats for the default date range of yesterday" do
      use_cassette "warship_account_stats_for_yesterday" do
        {:ok, result} = Account.stats_for_yesterday(@example_id)

        assert 1 = result[:meta].count

        first_atom =
          @example_id
          |> Integer.to_string()
          |> String.to_atom()

        assert %{^first_atom => _} = result[:data]
      end
    end

    test "returns a single error if one of the ids is invalid" do
      use_cassette "warship_account_stats_for_yesterday_with_error" do
        {:error, error} = Account.stats_for_yesterday("fake_id")

        assert %{
                 field: "account_id",
                 message: "INVALID_ACCOUNT_ID",
                 code: 407,
                 value: "fake_id"
               } = error
      end
    end
  end

  describe "Account.stats_for_dates/2 with a single account id" do
    test "returns the account's stats for the date range" do
      use_cassette "warship_account_stats_for_dates" do
        {:ok, result} = Account.stats_for_dates(@example_id, [~D[2018-03-14], ~D[2018-03-15]])

        assert 1 = result[:meta].count

        first_atom =
          @example_id
          |> Integer.to_string()
          |> String.to_atom()

        assert %{^first_atom => _} = result[:data]
      end
    end

    test "returns a single error if one of the ids is invalid" do
      use_cassette "warship_account_stats_for_dates_with_error" do
        {:error, error} = Account.stats_for_dates("fake_id", [~D[2018-03-14], ~D[2018-03-15]])

        assert %{
                 field: "account_id",
                 message: "INVALID_ACCOUNT_ID",
                 code: 407,
                 value: "fake_id"
               } = error
      end
    end
  end
end
