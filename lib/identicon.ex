defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.

  ## Example

      iex>Identicon.main "test", 250, "generated_identicon/"
      :ok
  """
  def main(input, size \\ 250, directory \\ "") do
    input 
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd
    |> build_pixel_map(size)
    |> draw_image(size)
    |> save_image(input, directory)
    
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

  @doc """
  Creates a hashed list from the input and returns the result as `%Identicon.Image{hex: hex}`
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end



  @doc """
  Adds a grid to `%Identicon.Image{}` as a list of tuples with the values and the index

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

  @doc """
    Adds a mirror of the row to it self
  """
  def mirror_row([first, second | _] = row) do
    row ++ [second, first]
  end

  @doc """
    Removes odd numbers from the grid 
  """
  def filter_odd(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn 
        {number, _} -> rem(number, 2) == 0
      end

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Extends the index of the grid to 50px squares as `{{x_top_left, y_top_left}, {x_bot_right, y_bot_right}}`
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image, size) do
    pixel_map = Enum.map grid, fn
      {_, index} -> 
        size = div(size, 5)
        x = rem(index, 5) * size
        y = div(index, 5) * size

        top_left = {x, y}
        bot_right = {x + size, y + size}

        {top_left, bot_right}
      end
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  Uses a erlang image library to create a image with the rectangles from pixel_map
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}, size) do
    image = :egd.create(size, size)
    fill = :egd.color(color)

    Enum.each pixel_map, fn {top_left, bot_right} ->
      :egd.filledRectangle(image, top_left, bot_right, fill)
    end

    :egd.render(image)
  end

  def save_image(image, input, directory) do
    File.write "#{directory}#{input}.png", image
  end
end
