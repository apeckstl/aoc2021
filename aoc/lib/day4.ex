defmodule Day4 do
  def part1(filePath) do
    {:ok, fileContents} = File.read(filePath)

    [firstline | boardLines] = String.split(fileContents, "\n\n", trim: true)
    order = String.split(firstline, ",") |> Enum.map(fn x -> String.to_integer(x) end)
    boards_tuple = {nil, 0, Enum.map(boardLines, fn x -> create_board(x) end)}

    {winner, just_called, _} = Enum.reduce_while(order, boards_tuple, fn turn, {_, _, b} ->
      new_boards = update_boards(b, turn)
      {winning_board, winner_exists?} = is_any_board_winning?(new_boards)
      if (not winner_exists?) do
        {:cont, {nil, turn, new_boards}}
      else
        {:halt, {winning_board, turn, new_boards}}
      end
    end)
    score = count_marked(winner)

    IO.puts("Winning board: ")
    print_board(winner)

    IO.puts("The number that was just called: " <> Integer.to_string(just_called))
    IO.puts("Board score: " <> Integer.to_string(score))

    score * just_called

  end

  def part2(filePath) do
    {:ok, fileContents} = File.read(filePath)
    String.split(fileContents, "\n", trim: true)
  end

  # takes a 5 line printed board from the input
  # returns a 2D array containing tuples of spaces on the board and whether they have been marked
  def create_board(str_rep) do
    rows = String.split(str_rep, "\n")

    Enum.map(rows, fn row ->
      Enum.map(String.split(row, " ", trim: true), fn item ->
        {String.to_integer(item), false}
      end)
    end)
  end

  def print_board(board) do
    pretty_board = Enum.map(board, fn x -> pretty_row(x) end)
    IO.puts(pretty_board)
  end

  def pretty_row(row) do
    Enum.reduce(row, "", fn {num, marked}, acc -> acc <> " " <> if marked do "x" else Integer.to_string(num) end end) <> "\n"
  end

  def update_boards(boards, to_mark) do
    Enum.map(boards, fn board -> update_board(board, to_mark) end)
  end

  def update_board(board, to_mark) do
    Enum.map(board, fn row -> Enum.map(row, fn {num, marked} -> if num == to_mark do {num, true} else {num, marked} end end) end)
  end

  def is_any_board_winning?(boards) do
    {Enum.find(boards, fn board -> is_board_winning?(board) end), Enum.any?(boards, fn board -> is_board_winning?(board) end)}
  end

  def is_board_winning?(board) do
    if Enum.reduce(board, false, fn row, acc -> if is_row_full(row) or acc do true else false end end) or has_column_full?(board) do
      true
    else
      false
    end
  end

  def is_row_full(row) do
    num_marked = Enum.reduce(row, 0, fn {_, marked}, acc -> if marked do acc + 1 else acc end end)
    if num_marked == 5 do
      true
    else
      false
    end
  end

  # checks if a given board has a full column
  def has_column_full?(board) do
    # for each column index, count all the rows where that index has the number marked
    Enum.reduce([0,1,2,3,4], false, fn idx, acc ->
      acc or Enum.reduce(board, 0, fn row, a ->
        {_, is_marked} = Enum.at(row, idx)
        if is_marked do a + 1 else a end end) == 5
      end)
  end

  def count_marked(board) do
    Enum.reduce(board, 0, fn row, acc -> acc + Enum.reduce(row, 0, fn {num, is_marked}, a -> if not is_marked do a + num else a end end) end)
  end
end
