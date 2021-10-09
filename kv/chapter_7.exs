Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_7.exs"
#                   CHAPTER 7
#________________________________________________

defmodule F do
  # IEX Display List Structure:
  def fun_1 do
    IO.puts [ 99, 97, 116 ]  # Returns: cat
    IO.puts [ 99, 97, 116, 0 ]  # Returns: [ 99, 97, 116, 0 ]
    IO.puts [ 1 | [ 2 | [ 3 | [] ] ] ] == [ 1, 2, 3 ]  # Returns: true
    [ head | tail ] = [ 1, 2, 3 ]
    IO.puts head  # Returns: 1
    tail  # Returns: [ 2, 3 ]
  end

  # IEX Write List Length Algorithm:
  def fun_2([ ]), do: 0
  def fun_2([ _head | tail ]), do: 1 + fun_2(tail)

  # IEX Square And Construct New List:
  def fun_3([ ]), do: [ ]
  def fun_3([ head | tail ]), do: [ head * head | fun_3(tail) ]

  # IEX Add And Construct New List:
  def fun_4([ ]), do: [ ]
  def fun_4([ head | tail ]), do: [ head + 1 | fun_4(tail) ]

  # IEX Construct Map Function:
  def fun_5([ ], _func), do: [ ]
  def fun_5([ head | tail ], function), do: [ function.(head) | fun_5(tail, function) ]

  # IEX Pass Functions And Values Recursively:
  def fun_6([], value, _), do: value
  def fun_6([head | tail], value, function), do: fun_6(tail, function.(head, value), function)

  # IEX Execute Above Functions:
  # Note: IO.puts displays list as symbols
  def fun_7 do
    IO.puts F.fun_2([ 1, 2, 3, 4, 5 ])  # Returns: 5
    IO.puts F.fun_3([ 1, 2, 3, 4, 5 ])  # Returns: [ 1, 4, 9, 16, 25 ]
    IO.puts F.fun_4([ 1, 2, 3, 4, 5 ])  # Returns: [ 2, 3, 4, 5, 6 ]
    IO.puts F.fun_5([ 1, 2, 3, 4, 5 ], fn (n) -> n * n end)  # Returns: [ 1, 4, 9, 16, 25 ]
    IO.puts F.fun_5([ 1, 2, 3, 4, 5 ], &(&1 * &1))  # Returns: [ 1, 4, 9, 16, 25 ]
    IO.puts F.fun_6([ 1, 2, 3, 4, 5 ], 0, &(&1 + &2))  # Returns: 15
    # Note: (0 + 1 + 2 + 3 + 4 + 5) = 15
    IO.puts F.fun_6([ 1, 2, 3, 4, 5 ], 1, &(&1 * &2))  # Returns: 120
    # Note: (1 * 1 * 2 * 3 * 4 * 5)
  end

  # Quiz (Page 77):
  # Q - Apply a function to each list element then sum everything:
  def fun_8([ ], _), do: 0
  def fun_8([ head | tail ], function), do: function.(head) + fun_8(tail, function)
  # Input: F.fun_8([ 1, 2, 3 ], &(&1 * &1))  # Returns: 14

  # Q - Get the max element in a list function:
  def fun_9(_, value \\ -999)
  def fun_9([ ], value), do: value
  def fun_9([ head | tail ], value) do
    value = cond do
      value > head -> value
      value <= head -> head
    end
    fun_9(tail, value)
  end
  # Input: F.fun_9([ 0, 45, -26, 84, 15 ])  # Returns: 84

  # Q - Alternative solution to above question:
  def fun_10([ a ]), do: a
  def fun_10([ head | tail ]), do: fun_6(tail, head, &fun_10/2)
  def fun_10(a, b) when a > b, do: a
  def fun_10(a, b) when a <= b, do: b
  # Input: F.fun_10([ 0, 45, -26, 84, 15 ])  # Returns: 84

  # Q - Add number to char index elements, wrap if greater than Z index:
  def fun_11([ ], _n), do: [ ]
  def fun_11([ head | tail ], n), do: [ fun_11(head + n) | fun_11(tail, n) ]
  def fun_11(n) do
    cond do
      n > 122 -> n - 26
      n <= 122 -> n
    end
  end
  # Input: IO.puts F.fun_11('ryvkve', 13)  # Returns: elixir
  # Note: If greater than 122 (Z) need to subtract 26.

  # ----------------- UNFORMATTED CODE --------------------- #

  # [ 1, 2, 3 | [ 4, 5, 6 ]]

  def swap([]), do: []
  def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
  # F.swap [1,2,3,4,5,6]
  # F.swap [1,2,3,4,5,6,7]
end

# [ timestamp, location_id, temperature, rainfall ]
defmodule A do
  def for_location_27([]), do: []
  def for_location_27([ [time, 27, temp, rain ] | tail]) do
  [ [time, 27, temp, rain] | for_location_27(tail) ]
  end
  def for_location_27([ _ | tail]), do: for_location_27(tail)

  def test_data do
    [
    [1366225622, 26, 15, 0.125],
    [1366225622, 27, 15, 0.45],
    [1366225622, 28, 21, 0.25],
    [1366229222, 26, 19, 0.081],
    [1366229222, 27, 17, 0.468],
    [1366229222, 28, 15, 0.60],
    [1366232822, 26, 22, 0.095],
    [1366232822, 27, 21, 0.05],
    [1366232822, 28, 24, 0.03],
    [1366236422, 26, 17, 0.025]
    ]
  end

  # IEX Input: A.for_location_27(A.test_data)

  def for_location([], _target_loc), do: []
  def for_location([ head = [_, target_loc, _, _ ] | tail], target_loc) do
  [ head | for_location(tail, target_loc) ]
  end
  def for_location([ _ | tail], target_loc), do: for_location(tail, target_loc)
  # IEX Input: A.for_location(A.test_data, 26)
  # Note: Match the head of the list where the second element is matched
  #       to target_loc and then match that whole head with the variable head.

  # Quiz (Page 81):
  # Q - Write a function MyList.span(from, to) that returns a list of the numbers from
  # from up to to.
  def quiz(from, to) when from <= to, do: quiz([ from ], from, to)
  def quiz(_, from, to) when from == to, do: [ to ]
  def quiz([ head ], from, to), do: [ head | quiz([ head + 1 ], from + 1, to) ]
  # IEX Input: A.quiz(-5, 14)

  # What is list.reduce again?
  # [1,2,3] ++ [4,5,6]
  # List.flatten([[[1], 2], [[[3]]]])
  # List.foldl([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end)
  # List.foldr([1,2,3], "", fn value, acc -> "#{value}(#{acc})" end)

  # list = [ 1, 2, 3 ]
  # List.replace_at(list, 2, "buckle my shoe")
end
