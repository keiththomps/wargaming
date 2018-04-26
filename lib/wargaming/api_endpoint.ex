defmodule Wargaming.ApiEndpoint do
  @moduledoc false

  defmacro __using__(api: api_module) do
    quote do
      @default_opts %{
        application_id: Application.get_env(:wargaming, :app_id, "123456")
      }

      @doc false
      def encode_query(opts) do
        @default_opts
        |> Map.merge(opts)
        |> URI.encode_query()
      end

      @doc false
      def get(url, opts \\ %{}) do
        url
        |> unquote(api_module).get(opts)
        |> case do
          {:ok, %{body: raw, status_code: code}} -> {code, raw}
          {:error, %{reason: reason}} -> {:error, reason}
        end
        |> decode
      end

      @doc false
      defp decode({:error, reason}), do: {:error, reason}

      defp decode({_status_code, raw_body}) do
        raw_body
        |> Poison.decode(keys: :atoms)
        |> case do
          {:ok, parsed} -> extract_error(parsed)
          _ -> {:error, raw_body}
        end
      end

      @doc false
      defp extract_error(%{status: "error"} = parsed_body) do
        {:error, parsed_body.error}
      end

      defp extract_error(parsed_body), do: {:ok, parsed_body}

      @doc false
      defp constructed_get(field_name, values, url, opts) when is_list(values) do
        query_string =
          opts
          |> Map.merge(%{field_name => Enum.join(values, ",")})
          |> encode_query()

        get(url <> "?#{query_string}")
      end

      defp constructed_get(field_name, value, url, opts) do
        query_string =
          opts
          |> Map.merge(%{field_name => value})
          |> encode_query()

        get(url <> "?#{query_string}")
      end
    end
  end
end
