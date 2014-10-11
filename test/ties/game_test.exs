defmodule TiesGameTest do
  use ExUnit.Case
  alias Ties.Game

  test "it can format boards" do
    output = Game.new(nil, nil)
    |> Game.format_board
    assert output == "\n0|1|2\n-----\n3|4|5\n-----\n6|7|8\n\n"
  end

  test "it can render rows" do
    output = [{0, :x}, {1, :o}, {2, nil}]
    |> Game.render_row
    assert output == "x|o|2"
  end
end
