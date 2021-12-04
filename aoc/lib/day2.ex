defmodule Day2 do
  def part1(filePath) do
    {:ok, fileContents} = File.read(filePath)
    lines = String.split(fileContents, "\n", trim: true) |> Enum.map(fn x -> String.split(x) end)
    {finalx, finaly} = Enum.reduce(lines, {0, 0}, fn line, acc -> update_position(acc, line) end)
    finalx * finaly
  end

  def part2(filePath) do
    {:ok, fileContents} = File.read(filePath)
    lines = String.split(fileContents, "\n", trim: true) |> Enum.map(fn x -> String.split(x) end)

    {finalx, finaly, _} =
      Enum.reduce(lines, {0, 0, 0}, fn line, acc -> update_position(acc, line) end)

    finalx * finaly
  end

  def update_position({x, y}, [direction, distance]) do
    dist = String.to_integer(distance)

    case direction do
      "up" -> {x, y - dist}
      "down" -> {x, y + dist}
      "forward" -> {x + dist, y}
    end
  end

  def update_position({x, y, aim}, [direction, amount]) do
    a = String.to_integer(amount)

    case direction do
      "up" -> {x, y, aim - a}
      "down" -> {x, y, aim + a}
      "forward" -> {x + a, y + aim * a, aim}
    end
  end
end
