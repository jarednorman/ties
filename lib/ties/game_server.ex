defmodule Ties.GameServer do
  alias Ties.Game

  def start_game(client1, client2) do
    spawn(__MODULE__, :game, [client1, client2])
  end

  def game(client1, client2) do
    _players = get_players([client1, client2])
    game = Game.new
    do_turn(game)
  end

  def do_turn(game) do
    case Game.finished?(game) do
      true -> false
      false -> false
    end
  end

  def get_players(players) do
    players = Enum.shuffle(players)
    %{x: players[0], o: players[1]}
  end
end
