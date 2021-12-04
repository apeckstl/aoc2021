defmodule Day1 do
  def part1(filePath) do
    {:ok, fileContents} = File.read(filePath)
    lines = String.split(fileContents, "\n", trim: true)

    # zip the list of measurements against itself offset by 1
    Enum.zip_reduce(lines, tl(lines), 0, fn x, y, acc ->
      if String.to_integer(y) > String.to_integer(x) do
        1
      else
        0
      end + acc
    end)
  end

  def part2(filePath) do
    {:ok, fileContents} = File.read(filePath)

    # get measurements as a list of integers
    lines = String.split(fileContents, "\n", trim: true) |> Enum.map(&String.to_integer(&1))

    # zip the list of measurements against itself offset by 1
    windows = Enum.zip([lines, tl(lines), tl(tl(lines))])

    Enum.zip_reduce(windows, tl(windows), 0, fn x, y, acc ->
      if Tuple.sum(y) > Tuple.sum(x) do
        1
      else
        0
      end + acc
    end)
  end
end
