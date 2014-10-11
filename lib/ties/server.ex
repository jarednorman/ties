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
    case :gen_tcp.listen(port, [:binary, packet: :line, active: false]) do
      {:ok, socket} ->
        IO.puts "bound to port #{port}"
        loop_acceptor(socket)
      {:error, :eaddrinuse} ->
        IO.puts "eaddrinuse, waiting then trying again"
        :timer.sleep 2000
        accept(port)
    end
  end

  defp loop_acceptor(socket) do
    {:ok, client1} = :gen_tcp.accept(socket)
    {:ok, client2} = :gen_tcp.accept(socket)
    Task.Supervisor.start_child(Ties.Server.TaskSupervisor, fn ->
      Ties.GameServer.start_game(client1, client2)
    end)
    loop_acceptor(socket)
  end
end
