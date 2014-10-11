defmodule Ties.Game do
  defstruct [x: nil, o: nil, game_state: nil]

  alias Ties.Game
  alias Ties.GameState

  def new(client1, client2) do
    [x_player, o_player] = Enum.shuffle([client1, client2])
    %__MODULE__{
      x: x_player,
      o: o_player,
      game_state: GameState.new
    }
  end

  def play(game) do
    game
    |> notify_players
    |> do_turn(:x, :o)
  end

  def do_turn(game, current_player, other_player) do
    do_turn(game, other_player, current_player)
  end

  def notify_players(%Game{x: x_player, o: o_player}) do
    :gen_tcp.send x_player, "You are X.\n"
    :gen_tcp.send o_player, "You are O.\n"
  end
end
