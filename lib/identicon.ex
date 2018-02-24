defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.

  ##Example
      iex> Identicon.main("test")
      %Identicon.Image{
        color: {9, 143, 107},
        hex: [9, 143, 107, 205, 70, 33, 211, 115, 202, 222, 78, 131, 38, 39, 180, 246]
      }
  """
  def main(input) do
    input 
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd
    
  end

  @doc """
  Takes in the data struct `%Identicon.Image{}` and saves it in `image`

    Then atribues to `r`, `g`, `b` the values of the first 3 items in the `hex: []` on the list and leaves the rest
      %Identicon.Image{hex: [r, g, b | _]} = image

    Never change a variable, only create a new one with diferent values
      %Identicon.Image{image | color: {r, g, b}}
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Returns a grid with the values

    `Enum.map(&mirror_row/1)` same as `Enum.map(&mirror_row(&1))`
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end

  def filter_odd(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn 
        {number, _} -> rem(number, 2) == 0
      end


    %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map do
    
  end

end
