defmodule Ties.GamesChannel do
  use Phoenix.Channel

  def notify(socket) do
    reply socket, "games", %{games: []}
  end

  def bug_the(socket) do
    :timer.sleep 1000
    notify socket
    bug_the socket
  end

  def join(socket, "games", _) do
    spawn fn -> bug_the socket end
    {:ok, socket}
  end
end
