defmodule Ties.Game do
  def new do
    Enum.map (0..8), fn(_) -> nil end
  end

  def x(game, tile) do
    update_tile(game, tile, :x)
  end

  def o(game, tile) do
    update_tile(game, tile, :o)
  end

  def winner([p,p,p,
              _,_,_,
              _,_,_]), do: p
  def winner([_,_,_,
              p,p,p,
              _,_,_]), do: p
  def winner([_,_,_,
              _,_,_,
              p,p,p]), do: p
  def winner([p,_,_,
              p,_,_,
              p,_,_]), do: p
  def winner([_,p,_,
              _,p,_,
              _,p,_]), do: p
  def winner([_,_,p,
              _,_,p,
              _,_,p]), do: p
  def winner([_,_,p,
              _,p,_,
              p,_,_]), do: p
  def winner([p,_,_,
              _,p,_,
              _,_,p]), do: p
  def winner(_), do: nil

  def finished?(game), do: winner(game) || Enum.all? game

  defp update_tile(game, tile, player) do
    List.update_at game, tile, fn(_) -> player end
  end
end

