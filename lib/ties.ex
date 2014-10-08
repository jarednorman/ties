defmodule Ties do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # worker(TestApp.Worker, [arg1, arg2, arg3])
      worker(Ties.Server, [])
    ]

    opts = [strategy: :one_for_one, name: Ties.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
