defmodule TiesGameTest do
  use ExUnit.Case
  alias Ties.Game

  def new_game, do: Game.new(nil, nil)
  def other_game do
    %{new_game | game_state: [nil, :x, nil, :o, :o, :x, nil, nil, nil]}
  end

  test "it can format boards" do
    assert Game.format_board(new_game)
    == "\n0|1|2\n-----\n3|4|5\n-----\n6|7|8\n\n"

    assert Game.format_board(other_game)
    == "\n0|x|2\n-----\no|o|x\n-----\n6|7|8\n\n"
  end

  test "it can render rows" do
    assert Game.render_row([{:x, 0}, {:o, 1}, {nil, 2}])
    == "x|o|2"
  end
end
