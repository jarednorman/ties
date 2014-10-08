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
    {:ok, client} = :gen_tcp.accept(socket)
    Task.Supervisor.start_child(Ties.Server.TaskSupervisor, fn -> serve(client) end)
    loop_acceptor(socket)
  end

  defp serve(socket) do
    socket
    |> read_line()
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} -> data
      # handle closed socket
    data
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end
end
