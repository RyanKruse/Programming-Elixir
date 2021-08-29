# Page 45 Problems
function_2 = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Fizz"
  (_, 0, _) -> "Buzz"
  (_, _, c) -> c
end
IO.puts function_2.(0, 0, 50)
IO.puts function_2.(0, 50, 50)
IO.puts function_2.(50, 50, 50)

function_3 = fn
  (n) -> function_2.(rem(n, 3), rem(n, 5), n)
end
IO.puts function_3.(10)
IO.puts function_3.(11)
IO.puts function_3.(12)
IO.puts function_3.(13)
IO.puts function_3.(14)
IO.puts function_3.(15)
IO.puts function_3.(16)

prefix = fn string1 -> (fn string2 -> string1 <> " " <> string2 end) end
mrs = prefix.("Mrs.")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks")

# Page 50.
Enum.map [1,2,3,4], &(&1 + 2)
Enum.map [1,2,3,4], &{IO.inspect &1}
