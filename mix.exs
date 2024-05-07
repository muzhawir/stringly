defmodule Stringly.MixProject do
  use Mix.Project

  def project do
    [
      app: :stringly,
      version: "0.0.2",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Stringly",
      source_url: "https://github.com/muzhawir/stringly"
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
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:styler, "~> 0.11", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "Stringly is an Elixir package packed with a wide range of string manipulation functions, it boosts Elixir's native `String` module with some extra handy tools."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/muzhawir/stringly"}
    ]
  end
end
