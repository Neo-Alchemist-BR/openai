defmodule Openai.MixProject do
  use Mix.Project

  def project do
    [
      app: :openai,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :vex],
      mod: {Openai.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.5"},
      {:jason, "~> 1.4"},
      {:exconstructor, "~> 1.2.7"},
      {:vex, "~> 0.9.0"},
      # Dev deps
      {:ex_doc, "~> 0.29"},
      {:faker, ">= 0.0.0", only: [:dev, :test]},
      {:dialyxir, "> 0.0.0", only: [:dev, :test], runtime: false}
    ]
  end
end
