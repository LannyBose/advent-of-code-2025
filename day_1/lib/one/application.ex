defmodule One.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: One.Worker.start_link(arg)
      # {One.Worker, arg}
    ]

    arg =
      System.argv()
      |> Enum.at(0)

    if arg do
      One.distance(arg)
      |> IO.inspect()
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: One.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
