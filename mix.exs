defmodule FIXME.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fixme,
      version: "0.0.6",
      elixir: ">= 1.6.0",
      description: "FIXME comments that raise after a certain point in time.",
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "FIXME",
      source_url: "https://github.com/henrik/fixme-elixir",
      docs: [
        main: "readme",
        extras: ["README.md"],
      ]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Henrik Nyh"],
      links: %{"GitHub" => "https://github.com/henrik/fixme-elixir"},
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
    ]
  end
end
