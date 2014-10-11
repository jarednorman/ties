defmodule Ties.Game do
  @derive [Access]
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
    player = game[current_player]
    tell player, "It is your turn.\n"
    tell player, format_board(game)
    tell player, "Where would you like to play? "
    turn = get_turn(player)
    do_turn(game, other_player, current_player)
  end

  def notify_players(game = %Game{x: x_player, o: o_player}) do
    tell x_player, "You are X.\n"
    tell o_player, "You are O.\n"
    game
  end

  defp tell(player, message) do
    :gen_tcp.send(player, message)
    player
  end

  defp listen(player) do
    {:ok, message} = :gen_tcp.recv(player, 0)
    message
  end

  defp get_turn(player) do
    player
    |> listen
    |> String.rstrip
    |> String.to_integer
  end

  defp format_board(game), do: "yolo\n"
end
