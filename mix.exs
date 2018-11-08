defmodule PixelaEx.MixProject do
  use Mix.Project

  @description """
  Pixela API client for Elixir
  """

  def project do
    [
      app: :pixela_ex,
      version: "1.0.0",
      elixir: "~> 1.7",
      description: @description,
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp package do
    [maintainers: ["otoyo"], licenses: ["CC0-1.0"], links: %{"Github" => "https://github.com/otoyo/pixela_ex"}]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :httpotion,
        :logger
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpotion, git: "https://github.com/otoyo/httpotion", branch: "fix-ibrowse4.4.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:poison, "~> 3.1"}
    ]
  end
end
