defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello
      :world
  """
  def hello do
    :world
  end

  # 1 Take input string

  def main(input) do
   input
   |> hash_input
   |> pick_color
   |> build_grid
   # |> pick_color
  end

  # 2 Convert string into MD5 hash
  # 3 Create list of numbers based on this string

  def hash_input(input) do
    # Input string
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  # 4 Picks a color 

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image)do
    %Identicon.Image{image | color: {r, g, b}}
  end

  # 5 Build a grid of squares 250 px * 250 px.
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirrow_row/1)
  end

  # 6 Mirror row [145,46,200] to [145,46,200,46,145].

  def mirrow_row(row) do
    # Take the first and the 2nd element [145,46,200]
    [first, second | _tail] = row

    # Append the values to the row [145,46,200,46,145]
    row ++ [second, first]

  end
  # 6 Converts this grid into an image

  # 7 Saves the img
end
