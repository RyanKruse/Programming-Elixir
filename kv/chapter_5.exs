# folder -> cmd -> iex -> c "Chapter_5.exs"
# git commit -m "xyz" -> git push -u origin main
Code.compiler_options(ignore_module_conflict: true)

#                   CHAPTER 5
#________________________________________________
#
# Binding Anonymous Functions
# sum = fn (a, b) -> a + b end
# sum.(1, 2)
# greet = fn -> IO.puts "Hello" end
# greet.()

# Function No-Parentheses
# f1 = fn a, b -> a * b end
# f1.(5,6)
# f2 = fn -> 99 end
# f2.()

# Pattern Matching
# swap = fn { a, b } -> { b, a } end
# swap.( { 6, 8 } )

# Quiz (pg.43)
# list_concat = fn (a, b) -> a ++ b end
# sum = fn (a, b, c) -> a + b + c end
# pair_tuple_to_list = fn {a, b} -> [a, b] end

defmodule Temp do
  # Multiple Bodies
  def temp_1 do
    handle_open = fn
      {:ok, file} -> "Read data: #{IO.read(file, :line)}"
      {_, error} -> "Error: #{:file.format_error(error)}"
    end
    IO.puts handle_open.(File.open("chapter_5.exs"))
    IO.puts handle_open.(File.open("nonexistent"))
  end

  # Quiz (pg.45)
  def temp_2 do
    # Question 1
    function_1 = fn
      (0, 0, _) -> "FizzBuzz"
      (0, _, _) -> "Fizz"
      (_, 0, _) -> "Buzz"
      (_, _, c) -> c
    end
    IO.puts function_1.(0, 0, 50)
    IO.puts function_1.(0, 50, 50)
    IO.puts function_1.(50, 0, 50)
    IO.puts function_1.(50, 50, 50)
    IO.puts "___"

    # Question 2
    function_2 = fn
      (n) -> function_1.(rem(n, 3), rem(n, 5), n)
    end
    IO.puts function_2.(10)
    IO.puts function_2.(11)
    IO.puts function_2.(12)
    IO.puts function_2.(13)
    IO.puts function_2.(14)
    IO.puts function_2.(15)
    IO.puts function_2.(16)
  end

  # Returning Functions
  def temp_3 do
    function = fn ->
      fn ->
        "Hello"
      end
    end
    IO.puts function.().()
  end

  # Binding Functions
  def temp_4 do
    function = fn -> (fn -> "Hello" end) end
    other = function.()
    IO.puts other.()
  end

  # Remembering Original Environment
  def temp_5 do
    greeter = fn name -> (fn -> "Hello #{name}" end) end
    dave_greeter = greeter.("Dave")
    IO.puts dave_greeter.()
  end

  # Parameterized Functions
  def temp_6 do
    add_n = fn n -> (fn other -> n + other end) end
    add_two = add_n.(2)
    add_five = add_n.(5)
    IO.puts add_two.(3)
    IO.puts add_five.(7)
  end

  # Quiz (pg.47)
  def temp_7 do
    prefix = fn string1 -> (fn string2 -> string1 <> " " <> string2 end) end
    mrs = prefix.("Mrs.")
    IO.puts mrs.("Smith")
    IO.puts prefix.("Elixir").("Rocks")
  end

  # Passing Functions
  def temp_8 do
    times_2 = fn n -> n * 2 end
    apply = fn (fun, value) -> fun.(value) end
    IO.puts apply.(times_2, 6)
  end

  # Passing Map Functions
  def temp_9 do
    list = [1, 3, 5, 7, 9]
    IO.puts [101, 102, 103, 104] == 'efgh'
    # IEx.configure(inspect: [charlists: :as_lists])
    IO.puts Enum.map list, fn elem -> elem * 2 end
    IO.puts Enum.map list, fn elem -> elem * elem end
    # IO.puts Enum.map list, fn elem -> elem > 6 end
  end

  # Pinned Function Values
  def temp_10 do
    mr_valim = Temp.for("Jose", "Oi!")
    IO.puts mr_valim.("Jose")
    IO.puts mr_valim.("Dave")
  end
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you"
    end
  end

  # Short Helper Functions (Order Sensitive)
  def temp_11 do
    add_one = &(&1 + 1)
    IO.puts add_one.(44)
    square = &(&1 * &1)
    IO.puts square.(8)
    speak = &(IO.puts(&1))
    IO.puts speak.("Hello")
    rnd = &(Float.round(&1, &2))
    IO.puts rnd.(8.15235, 3)
  end

  # List and Tuple Helper Functions
  def temp_12 do
    s = &"bacon and #{&1}"
    IO.puts s.("custard")
    match_end = &~r/.*#{&1}$/
    IO.puts "cat" =~ match_end.("t")
    IO.puts "cat" =~ match_end.("!")
    divrem = &{div(&1, &2), rem(&1, &2)}
    divrem.(13, 5)  # Cannot IO.Puts Tuple
  end
end
