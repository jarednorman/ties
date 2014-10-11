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
    game[current_player]
    |> tell("It is your turn.\n")
    |> tell(format_board(game))
    |> tell("Where would you like to play? ")
    |> get_turn
    |> play_turn(game, current_player)
    |> IO.inspect
    |> do_turn(other_player, current_player)
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

  defp play_turn(tile, game = %Game{game_state: game_state}, player) do
    game_state = GameState.update_tile(game_state, tile, player)
    %{game | game_state: game_state}
  end

  def format_board(%Game{game_state: game_state}) do
    "\n" <> render_board(game_state) <> "\n\n"
  end

  def render_board(game_state) do
    game_state
    |> Enum.with_index
    |> Enum.chunk(3)
    |> Enum.map(&render_row(&1))
    |> Enum.join("\n-----\n")
  end

  def render_row(row) do
    row
    |> Enum.map(fn
      ({nil, index}) -> index
      ({player, _}) -> player
    end)
    |> Enum.join("|")
  end
end
