Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_5.exs"
#                   CHAPTER 5
#________________________________________________

# IEX Binding Anonymous Functions:
# sum = fn (a, b) -> a + b end
# sum.(1, 2)  # Returns: 3
# greet = fn -> IO.puts "Hello" end
# greet.()  # Returns: Hello

# IEX Function No-Parentheses:
# f1 = fn a, b -> a * b end
# f1.(5, 6)  # Returns: 30
# f2 = fn -> 99 end
# f2.()  # Returns: 99

# IEX Pattern Matching:
# swap = fn { a, b } -> { b, a } end
# swap.( { 6, 8 } )  # Returns: { 8, 6 }

# IEX Quiz (Page 43) - Create functions that do the following:
# list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]
# sum.(1, 2, 3) #=> 6
# pair_tuple_to_list.( { 1234, 5678 } ) #=> [ 1234, 5678 ]

# IEX Quiz Answers:
# list_concat = fn (a, b) -> a ++ b end  # Returns: [:a, :b, :c, :d]
# sum = fn (a, b, c) -> a + b + c end  # Returns: 6
# pair_tuple_to_list = fn { a, b } -> [a, b] end  # Returns: [ 1234, 5678 ]

defmodule F do
  # IEX Multiple Function Bodies:
  def fun_1 do
    handle_open = fn
      {:ok, file} -> "Read data: #{IO.read(file, :line)}"
      {_, error} -> "Error: #{:file.format_error(error)}"
      # Note: Number of arities (2) must match on all cases
    end
    IO.puts handle_open.(File.open("chapter_5.exs"))  # Returns: read data
    IO.puts handle_open.(File.open("nonexistent"))  # Returns: error
  end

  # IEX Quiz (Page 45) - Create FizzBuzz script:
  def fun_2 do
    # IEX Quiz Question 1:
    fizzbuzz_1 = fn
      (0, 0, _) -> "FizzBuzz"
      (0, _, _) -> "Fizz"
      (_, 0, _) -> "Buzz"
      (_, _, c) -> c
    end
    # Returns: matching string
    IO.puts fizzbuzz_1.(0, 0, 50)
    IO.puts fizzbuzz_1.(0, 50, 50)
    IO.puts fizzbuzz_1.(50, 0, 50)
    IO.puts fizzbuzz_1.(50, 50, 50)
    IO.puts "___"

    # IEX Quiz Question 2:
    fizzbuzz_2 = fn
      (n) -> fizzbuzz_1.(rem(n, 3), rem(n, 5), n)
    end
    # Returns: matching string
    IO.puts fizzbuzz_2.(10)
    IO.puts fizzbuzz_2.(11)
    IO.puts fizzbuzz_2.(12)
    IO.puts fizzbuzz_2.(13)
    IO.puts fizzbuzz_2.(14)
    IO.puts fizzbuzz_2.(15)
    IO.puts fizzbuzz_2.(16)
    IO.puts "___"

    # IEX Bonus Question 3:
    # for n <- 10..16, do: fizzbuzz_2.(n)  # Returns: list of outputs
    fizzbuzz_3 = fn ->
      Enum.each(10..16, &IO.puts(fizzbuzz_2.(&1)))
    end
    fizzbuzz_3.()  # Returns: matching string
  end

  # IEX Returning Functions:
  def fun_3 do
    function = fn ->
      fn ->
        "Hello"
      end
    end
    IO.puts function.().()  # Returns: Hello
  end

  # IEX Binding Functions:
  def fun_4 do
    function = fn -> (fn -> "Hello" end) end
    other = function.()
    IO.puts other.()  # Returns: Hello
  end

  # IEX Remembering Original Environment:
  def fun_5 do
    greeter = fn name -> (fn -> "Hello #{name}" end) end
    dave_greeter = greeter.("Dave")
    IO.puts dave_greeter.()  # Returns: Hello Dave
  end

  # IEX Parameterized Functions:
  def fun_6 do
    add_n = fn n -> (fn other -> n + other end) end
    add_two = add_n.(2)
    add_five = add_n.(5)
    IO.puts add_two.(3)  # Returns: 5
    IO.puts add_five.(7)  # Returns: 12
  end

  # IEX Quiz (Page 47) - Create prefix function:
  def fun_7 do
    prefix = fn string1 -> (fn string2 -> string1 <> " " <> string2 end) end
    mrs = prefix.("Mrs.")
    IO.puts mrs.("Smith")  # Returns: Mrs. SMmith
    IO.puts prefix.("Elixir").("Rocks")  # Returns: Elixir Rocks
  end

  # IEX Passing Functions:
  def fun_8 do
    times_2 = fn n -> n * 2 end
    apply = fn (fun, value) -> fun.(value) end
    IO.puts apply.(times_2, 6)  # Returns: 12
  end

  # IEX Passing Map Functions (Problematic):
  def fun_9 do
    list = [0, 1, 3, 5, 7, 9]
    IO.puts [101, 102, 103, 104] == 'efgh'
    IO.puts Enum.map list, fn elem -> elem * 2 end  # Returns: list times 2
    IO.puts Enum.map list, fn elem -> elem * elem end  # Returns: list squared
   Enum.map list, fn elem -> elem > 6 end  # Returns: list boolean
  end

  # IEX Pinned Function Values:
  def fun_10 do
    mr_valim = F.for("Jose", "Oi!")
    IO.puts mr_valim.("Jose")  # Returns: Oi! Jose
    IO.puts mr_valim.("Dave")  # Returns: I don't know you
  end
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you"
    end
  end

  # IEX Short Helper Functions (Order Sensitive):
  def fun_11 do
    add_one = &(&1 + 1)
    IO.puts add_one.(44)  # Returns: 45
    square = &(&1 * &1)
    IO.puts square.(8)  # Returns: 64
    speak = &(IO.puts(&1))
    IO.puts speak.("Hello")  # Returns: Hello
    rnd = &(Float.round(&1, &2))  # Note: abstracts away
    IO.puts rnd.(8.15235, 3)  # Returns: 8.152
    _rnd = &(Float.round(&2, &1))  # Note: does not abstract away
  end

  # IEX List and Tuple Helper Functions:
  def fun_12 do
    s = &"bacon and #{&1}"
    IO.puts s.("custard")  # Returns: bacon and custard
    match_end = &~r/.*#{&1}$/
    IO.puts "cat" =~ match_end.("t")  # Returns: true
    IO.puts "cat" =~ match_end.("!")  # Returns: false
    divrem = &{div(&1, &2), rem(&1, &2)}
    divrem.(13, 5)  # Returns: { 2, 3 }
    # Note: Cannot IO.Puts Tuple
  end

  # IEX Wrapping Anonymous Functions:
  def fun_13 do
    l = &length/1
    IO.puts l.([ 1, 3, 5, 7 ])  # Returns: 4
    len = &Enum.count/1
    IO.puts len.([ 1, 3, 5, 7 ])  # Returns: 4
    m = &Kernel.min/2
    IO.puts m.(99, 88)  # Returns: 88

    IO.puts Enum.map [ 1, 2, 3, 4 ], &(&1 + 1)  # Returns: list plus 1
    IO.puts Enum.map [ 1, 2, 3, 4 ], &(&1 * &1)  # Returns: list squared
    Enum.map [ 1, 2, 3, 4 ], &(&1 < 3)  # Returns: list boolean
  end

  # IEX Quiz (Page 50) - Rewrite using & notation:
  def fun_14 do
    Enum.map [ 1, 2, 3, 4 ], fn x -> x + 2 end
    Enum.each [ 1, 2, 3, 4 ], fn x -> IO.inspect x end

    # IEX Quiz Answers:
    Enum.map [ 1, 2, 3, 4 ], &(&1 + 2)  # Returns: list plus 2
    Enum.map [ 1, 2, 3, 4 ], &(IO.inspect &1)  # Returns: list element
  end
end
