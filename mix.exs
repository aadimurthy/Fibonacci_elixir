defmodule FibonacciServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :fibonacci_server,
      version: "0.1.0",
      elixir: "~> 1.9-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      tool: Coverex.Task
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FibonacciServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.0"},
      {:stream_data, "~> 0.1", only: :test},
      {:coverex, "~> 1.4.10", only: :test}
    ]
  end
end
