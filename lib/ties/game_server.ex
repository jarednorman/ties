defmodule Ties.GameServer do
  alias Ties.Game

  def start_game(client1, client2) do
    spawn_link(__MODULE__, :game, [client1, client2])
  end

  def game(client1, client2) do
    Game.new(client1, client2)
    |> Game.play
  end
end
