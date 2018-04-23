defmodule WargamingTest.Config do
  defmacro __using__(_) do
    quote do
      def config_wargaming_with(conf) do
        Mix.Config.persist(wargaming: conf)
      end

      def reset_wargaming_config do
        Mix.Config.persist(wargaming: %{region: nil})
      end
    end
  end
end
