defmodule Day3 do
  def part1(filePath) do
    {:ok, fileContents} = File.read(filePath)

    lines =
      String.split(fileContents, "\n", trim: true)
      |> Enum.map(fn x -> String.graphemes(x)
      |> Enum.map(fn y -> if String.to_integer(y) == 0 do -1 else 1 end end) end)

    unnormalized = Enum.reduce(lines, fn line, acc -> Enum.zip_reduce([line, acc], [], fn elements, acc1 -> acc1 ++ [Enum.sum(elements)] end) end)
    gammaRate = String.to_integer(getGammaRate(unnormalized), 2)
    epsilonRate = String.to_integer(getEpsilonRate(unnormalized), 2)

    gammaRate*epsilonRate
  end

  def part2(filePath) do
    {:ok, fileContents} = File.read(filePath)

  end

  def getGammaRate(unnormalized) do
    to_string(Enum.map(unnormalized, fn el -> if el > 0 do '1' else '0' end end))
  end

  def getEpsilonRate(unnormalized) do
    to_string(Enum.map(unnormalized, fn el -> if el > 0 do '0' else '1' end end))
  end
end
