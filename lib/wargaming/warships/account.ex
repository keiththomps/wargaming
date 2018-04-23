defmodule Wargaming.Warships.Account do
  @moduledoc """
  Account provides functions for interacting with the
  WarGaming.net World of Warships Account API.
  """

  @account_list "/account/list/"

  @default_opts %{
    application_id: Application.get_env(:wargaming, :app_id)
  }

  alias Wargaming.Warships

  def search(query, opts \\ %{}) do
    query_string =
      @default_opts
      |> Map.merge(opts)
      |> Map.merge(%{search: query})
      |> URI.encode_query()

    (@account_list <> "?#{query_string}")
    |> Warships.get()
    |> case do
      {:ok, %{body: raw, status_code: code}} -> {code, raw}
      {:error, %{reason: reason}} -> {:error, reason}
    end
    |> decode
  end

  defp decode({:error, reason}), do: {:error, reason}

  defp decode({_status_code, raw_body}) do
    raw_body
    |> Poison.decode(keys: :atoms)
    |> case do
      {:ok, parsed} -> {:ok, parsed}
      _ -> {:error, raw_body}
    end
  end
end
