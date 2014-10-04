defmodule TiesGameTest do
  use ExUnit.Case
  alias Ties.Game

  test "it identifies when x wins" do
    winner = Game.new()
    |> Game.x(0)
    |> Game.o(4)
    |> Game.x(1)
    |> Game.o(3)
    |> Game.x(2)
    |> Game.winner
    assert winner == :x
  end

  test "it identifies when o wins" do
    winner = Game.new()
    |> Game.x(1)
    |> Game.o(2)
    |> Game.x(3)
    |> Game.o(5)
    |> Game.x(0)
    |> Game.o(8)
    |> Game.winner
    assert winner == :o
  end

  test "it identifies when there is no winner" do
    winner = Game.new()
    |> Game.x(0)
    |> Game.o(1)
    |> Game.x(2)
    |> Game.o(3)
    |> Game.x(4)
    |> Game.o(6)
    |> Game.x(5)
    |> Game.o(8)
    |> Game.x(7)
    |> Game.winner
    assert winner == nil
  end

  test "it identifies whether the game is finished in ties" do
    game = Game.new()
    |> Game.x(0)
    |> Game.o(1)
    |> Game.x(2)
    |> Game.o(3)
    |> Game.x(4)
    |> Game.o(6)
    |> Game.x(5)
    |> Game.o(8)
    refute Game.finished?(game)
    game = game
    |> Game.x(7)
    assert Game.finished?(game)
  end

  test "it identifies whether the game is finished when there is a winner" do
    game = Game.new()
    |> Game.x(0)
    |> Game.o(1)
    |> Game.x(3)
    |> Game.o(2)
    |> Game.x(6)
    assert Game.finished?(game)
  end
end
