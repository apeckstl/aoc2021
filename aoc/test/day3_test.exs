defmodule Day3Test do
  use ExUnit.Case

  test "part1 test case 1" do
    assert Day3.part1("input/test_cases/day3_1.txt") == 198
  end

  @tag :skip
  test "part2 test case 1" do
    assert Day3.part2("input/test_cases/day3_1.txt") == 900
  end
end
