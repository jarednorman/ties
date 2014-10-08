defmodule TiesGameStateTest do
  use ExUnit.Case
  alias Ties.GameState

  test "it identifies when x wins" do
    winner = GameState.new()
    |> GameState.x(0)
    |> GameState.o(4)
    |> GameState.x(1)
    |> GameState.o(3)
    |> GameState.x(2)
    |> GameState.winner
    assert winner == :x
  end

  test "it identifies when o wins" do
    winner = GameState.new()
    |> GameState.x(1)
    |> GameState.o(2)
    |> GameState.x(3)
    |> GameState.o(5)
    |> GameState.x(0)
    |> GameState.o(8)
    |> GameState.winner
    assert winner == :o
  end

  test "it identifies when there is no winner" do
    winner = GameState.new()
    |> GameState.x(0)
    |> GameState.o(1)
    |> GameState.x(2)
    |> GameState.o(3)
    |> GameState.x(4)
    |> GameState.o(6)
    |> GameState.x(5)
    |> GameState.o(8)
    |> GameState.x(7)
    |> GameState.winner
    assert winner == nil
  end

  test "it identifies whether the game is finished in ties" do
    game = GameState.new()
    |> GameState.x(0)
    |> GameState.o(1)
    |> GameState.x(2)
    |> GameState.o(3)
    |> GameState.x(4)
    |> GameState.o(6)
    |> GameState.x(5)
    |> GameState.o(8)
    refute GameState.finished?(game)
    game = game
    |> GameState.x(7)
    assert GameState.finished?(game)
  end

  test "it identifies whether the game is finished when there is a winner" do
    game = GameState.new()
    |> GameState.x(0)
    |> GameState.o(1)
    |> GameState.x(3)
    |> GameState.o(2)
    |> GameState.x(6)
    assert GameState.finished?(game)
  end
end
