defmodule Day3 do
  def part1(filePath) do
    {:ok, fileContents} = File.read(filePath)

    lines =
      String.split(fileContents, "\n", trim: true)
      |> Enum.map(fn x ->
        String.graphemes(x)
        |> Enum.map(fn y ->
          if String.to_integer(y) == 0 do
            -1
          else
            1
          end
        end)
      end)

    unnormalized =
      Enum.reduce(lines, fn line, acc ->
        Enum.zip_reduce([line, acc], [], fn elements, acc1 -> acc1 ++ [Enum.sum(elements)] end)
      end)

    gammaRate = String.to_integer(getGammaRate(unnormalized), 2)
    epsilonRate = String.to_integer(getEpsilonRate(unnormalized), 2)

    gammaRate * epsilonRate
  end

  def part2(filePath) do
    {:ok, fileContents} = File.read(filePath)
    lines = String.split(fileContents, "\n", trim: true)
    oxygenGeneratorRating = String.to_integer(Enum.at(reduceData(lines, "1", 0), 0), 2)
    co2ScrubberRating = String.to_integer(Enum.at(reduceData(lines, "0", 0), 0), 2)

    oxygenGeneratorRating * co2ScrubberRating
  end

  def getGammaRate(unnormalized) do
    to_string(
      Enum.map(unnormalized, fn el ->
        if el > 0 do
          '1'
        else
          '0'
        end
      end)
    )
  end

  def getEpsilonRate(unnormalized) do
    to_string(
      Enum.map(unnormalized, fn el ->
        if el > 0 do
          '0'
        else
          '1'
        end
      end)
    )
  end

  def reduceData(data, criteria, idx) do
    if length(data) == 1 do
      data
    else
      match =
        if criteria == "1" do
          findMostCommon(data, idx)
        else
          findLeastCommon(data, idx)
        end

      reducedData = Enum.filter(data, fn x -> String.at(x, idx) == match end)
      reduceData(reducedData, criteria, idx + 1)
    end
  end

  def findMostCommon(data, idx) do
    sumOnes =
      Enum.reduce(data, 0, fn line, acc ->
        if String.at(line, idx) == "1" do
          acc + 1
        else
          acc
        end
      end)

    if sumOnes >= length(data) / 2 do
      "1"
    else
      "0"
    end
  end

  def findLeastCommon(data, idx) do
    sumOnes =
      Enum.reduce(data, 0, fn line, acc ->
        if String.at(line, idx) == "0" do
          acc + 1
        else
          acc
        end
      end)

    if sumOnes > length(data) / 2 do
      "1"
    else
      "0"
    end
  end
end
