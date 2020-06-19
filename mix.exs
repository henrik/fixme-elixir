defmodule FIXME.Mixfile do
  use Mix.Project

  def project do
    [
      app: :fixme,
      version: "0.0.5",
      elixir: ">= 1.6.0",
      description: "FIXME comments that raise after a certain point in time.",
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
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

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
