defmodule WargamingTest.Warships.AccountTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Wargaming.Warships.Account
  alias Wargaming.Warships.Account

  describe "Account.search/2" do
    test "returns list of user nicknames and ids" do
      use_cassette "warship_account_search" do
        {:ok, search} = Account.search("CallMeR")

        assert 7 = search[:meta].count
        assert %{nickname: "CallMeRabbi", account_id: 1_030_494_954} = List.first(search[:data])
      end
    end
  end
end
