defmodule Wargaming.MixProject do
  use Mix.Project

  def project do
    [
      app: :wargaming,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Wargaming",
      source_url: "https://github.com/keiththomps/wargaming"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.1"},
      {:poison, "~> 3.1"},
      {:exvcr, "~> 0.10.2", only: [:test, :dev]}
    ]
  end

  defp description() do
    "Client library for WarGaming.net related APIs."
  end

  defp package() do
    [
      name: "wargaming",
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Keith Thompson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/keiththomps/wargaming"}
    ]
  end
end
