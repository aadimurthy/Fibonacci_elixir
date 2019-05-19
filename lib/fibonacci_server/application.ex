defmodule FibonacciServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    Fibonacci.start
    children = [
      {Plug.Cowboy, scheme: :http, plug: Fib.Router, options: [port: 8080]},
    ]
    opts = [strategy: :one_for_one, name: Fib.Supervisor]
    Logger.info("Starting application...")
    Supervisor.start_link(children, opts)
  end
end
