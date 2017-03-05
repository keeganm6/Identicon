defmodule Identicon do
  @moduledoc """
    Identicon converts a string into an identicon image.
  """

  @doc """
  Main function; input = "name" and output is identicon-file. Uses the other functions.

  ## Examples

      iex> Identicon.main("froodi")
      [{177, 0}, {156, 1}, {112, 2}, {156, 3}, {177, 4}, {71, 5}, {189, 6}, {13, 7},
      {189, 8}, {71, 9}, {77, 10}, {75, 11}, {195, 12}, {75, 13}, {77, 14}, {39, 15},
      {171, 16}, {16, 17}, {171, 18}, {39, 19}, {61, 20}, {76, 21}, {40, 22},
      {76, 23}, {61, 24}]

  """
  #1 Read string
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid

  end

  @doc """
  Function hash_input/1 converts string into Identicon.Image struct.

  ## Examples

      iex> Identicon.hash_input("froodi")
      %Identicon.Image{color: nil,
      hex: [177, 156, 112, 71, 189, 13, 77, 75, 195, 39, 171, 16, 61, 76, 40, 184]}

  """
  #2 Convert string "input" with MD5 into Hash
  #3 Convert Hash into Line of Numbers
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Function pick_color/1 converts string into Identicon.Image struct.

  ## Examples

      iex> image = Identicon.hash_input("froodi")
      %Identicon.Image{color: nil,
      hex: [177, 156, 112, 71, 189, 13, 77, 75, 195, 39, 171, 16, 61, 76, 40, 184]}
      iex> Identicon.pick_color(image)
      %Identicon.Image{color: {177, 156, 112},
      hex: [177, 156, 112, 71, 189, 13, 77, 75, 195, 39, 171, 16, 61, 76, 40, 184]}

  """
  #4 Pick Color and make Image struct
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail ]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Function build_grid/1 converts list of sub-lists with 3 elements 
  into list with tuples of 5 elements (3 mirrored). (See mirror_row/1.)

  ## Examples

      iex> Identicon.hash_input("froodi")
      %Identicon.Image{color: nil,
      hex: [177, 156, 112, 71, 189, 13, 77, 75, 195, 39, 171, 16, 61, 76, 40, 184]}

  """
  #5 Build Grid from Line of Numbers and Color
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)              # converts hex-list into list with sub-list of 3
    |> Enum.map(&mirror_row/1)    # iterates over list and mirrors each row (3 to 5)
    |> List.flatten               # converts list of sub-lists into one list of values
    |> Enum.with_index            # converts list of values into list of {value, index}-tuples
  end

  @doc """
  Function mirror_row/1 converts list of [ 1, 2, 3 ] into mirrored list [ 1,2,3,2,1 ]
  
  ## Examples

      iex> row = [ 1, 4, 16 ]
      [1, 4, 16]
      iex> Identicon.mirror_row(row)
      [1, 4, 16, 4, 1]

  """
  #6 Mirror row 1,2,3 into 1,2,3,2,1
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  #6 Convert Grid into Image


  #7 Save Image

end
