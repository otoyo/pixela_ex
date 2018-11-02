defmodule PixelaEx.Mixfile do
  use Mix.Project

  @description """
  Pixela API client for Elixir
  """

  def project do
    [app: :pixela_ex,
     version: "1.0.0",
     elixir: "~> 1.4",
     description: @description,
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  defp package do
    [maintainers: ["otoyo"],
     licenses: ["CC0-1.0"],
     links: %{"Github" => "https://github.com/otoyo/pixela_ex"}]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:httpotion, :logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpotion, git: "https://github.com/otoyo/httpotion", branch: "fix-ibrowse4.4.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:poison, "~> 3.1"}
    ]
  end
end
