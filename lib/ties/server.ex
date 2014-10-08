defmodule Ties.Server do
  def start_link() do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: Ties.Server.TaskSupervisor]]),
      worker(Task, [Ties.Server, :accept, [55555]])
    ]

    opts = [strategy: :one_for_one, name: Ties.Server.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def accept(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false])
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client1} = :gen_tcp.accept(socket)
    {:ok, client2} = :gen_tcp.accept(socket)
    Task.Supervisor.start_child(Ties.Server.TaskSupervisor, fn ->
      Ties.GameManager.start_game(client1, client2)
    end)
    loop_acceptor(socket)
  end
end
