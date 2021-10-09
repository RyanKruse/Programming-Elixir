Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_6.exs"
#                   CHAPTER 6
#________________________________________________

defmodule F do
  # IEX Double Input Value:
  def fun_1(n) do
    n * 2
  end

  # IEX Same Syntax Above:
  def fun_2(n), do: n * 2

  # IEX Reuse Name And Double 2 Input Values:
  def fun_1(n, m) do
    { fun_1(n), fun_2(m) }
  end

  # IEX Multiple Line Function Using Parentheses:
  def fun_3(greeting, name), do: (
    IO.puts greeting
    IO.puts "How're you doing, #{name}?"
  )

  # IEX Using One-Liners For Simple Functions (Halve):
  def fun_4(n), do: n / 2

  # IEX Quiz (Page 55):
  # Q - Multiply Input Parameters By Three:
  def fun_5(n) do
    n * 3
  end
  # Q - Reuse Functions Ontop Each Other:
  def fun_6(n) do
    F.fun_1(F.fun_1(n))
  end

  # IEX Factorial Function Using Recursion:
  def fun_7(0), do: 1  # Note: base case must occur first, executes top-to-bottom
  def fun_7(n), do: n * fun_7(n - 1)  # Note: keep same function names together

  # IEX Quiz (Page 57):
  # Q - Calculate Sum Of Integers From 1 To N:
  def fun_8(1), do: 1
  def fun_8(n), do: n + fun_8(n - 1)

  # Q - Express Greatest Common Divisor Function:
  def fun_9(x, 0), do: x
  def fun_9(x, y), do: fun_9(y, rem(x, y))

  # IEX Gaurd Clauses On Number:
  def fun_10(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end

  # IEX Gaurd Clauses On List:
  def fun_10(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end

  # IEX Gaurd Clauses On Atom:
  def fun_10(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end

  # IEX Function Of Last Resort:
  def fun_10(x) do
    IO.puts "#{x} is unknown"
  end

  # IEX Gaurded Factorial Function:
  def fun_11(0), do: 1
  def fun_11(n) when is_integer(n) and n > 0 do
    n * fun_11(n - 1)
  end

  # Note: page 59 contains all gaurd-clause limitations

  # IEX Functions With Default Parameters:
  # Note: must have 2 - 4 inputs
  # Note: population with 2 inputs -> p1, p4
  # Note: population with 3 inputs -> p1, p2, p4
  # Note: population with 4 inputs -> p1, p2, p3, p4
  def fun_12(p1, p2 \\ 200, p3 \\ 300, p4) do
    IO.inspect [p1, p2, p3, p4]
  end

  # Error: function never executes as previous function also shares 2 inputs
  # def fun_12(p1, p2) do
  #   IO.inspect [p1, p2]
  # end

  # IEX Default Parameter Function With No Body:
  def fun_13(p1, p2 \\ 123)
  def fun_13(p1, p2) when is_list(p1), do: "Passed a list and #{p2}"
  def fun_13(p1, p2), do: "Passed in #{p1} and #{p2}"
  def fun_13 do
    IO.puts F.fun_13(99)  # Returns: Passed in 99 and 123
    IO.puts F.fun_13(99, "cat")  # Returns: Passed in 99 and cat
    IO.puts F.fun_13([99])  # Returns: Passed a list and 123
    IO.puts F.fun_13([99], "dog")  # Returns: Passed a list and dog
  end

  # IEX Quiz (Page 62) - Create a binary search function with gaurd clauses:
  def fun_14(guess, min..max) when guess in min..max do
    list = Enum.to_list min..max
    index = div(Enum.count(list), 2) - 1
    mid = Enum.at(list, index)
    header = "We guessed #{mid} (#{min}-#{max})."
    # Note: Could use cond do ... end instead of if ... else
    if guess > mid do
      IO.puts "#{header} It is too low"
      F.fun_14(guess, (mid+1)..max)
    else if guess < mid do
      IO.puts "#{header} It is too high"
      F.fun_14(guess, min..(mid-1))
    else
      IO.puts "#{header} The answer is #{mid}"
    end
    end
  end
  def fun_14(_, _), do: IO.puts "Error: Invalid Inputs."

  # IEX Private Function:
  # Note: only callable in module that declared it
  # Note: terminal can call fun_16(n) but cannot call fun_15(n)
  defp fun_15(n), do: n + 1
  def fun_16(n), do: fun_15(n)

  # IEX Quick Function Passing Arguments To Right:
  # Returns: list of squared numbers within range less than 40.
  def fun_17(range) do
    (range) |> Enum.map(&(&1*&1)) |> Enum.filter(&(&1 < 40))
  end

  # IEX Nested Modules:
  def fun_18, do: "Outer Function (F Module)"
  defmodule G do
    def fun_18, do: "Inner Function (F.G Module)"
    defmodule H do
      def fun_18, do: "Nested Inner Function (F.G.H Module)"
    end
  end
  defmodule G.I do
    def fun_18, do: "Nested Inner Function (F.G.I Module)"
  end

  # IEX Flatten List Function:
  def fun_19 do
    List.flatten [ 1, [ 2, 3 ], 4 ]  # Returns: [ 1, 2, 3, 4 ]
  end

  # IEX Import Module Functions Directly:
  def fun_20 do
    import List, only: [flatten: 1, duplicate: 2]
    flatten [ 1, [ 2, 3 ], 4 ]  # Returns: [ 1, 2, 3, 4 ]
  end

  # IEX Module Metadata Attribute:
  # Note: cannot declare inside functions
  # Note: read top-down; value used is what functions see when defined
  @basic_list [ 1, [ 2, 3 ], 4 ]

  # IEX Import Module Functions Generally:
  def fun_21 do
    import List, only: :functions
    flatten @basic_list  # Returns: [ 1, 2, 3, 4 ]
  end

  # IEX Redefining Metadata Attribute:
  @basic_list [ 5, [ 6, 7 ], 8 ]

  # IEX Create Alias For Module:
  def fun_22 do
    alias F, as: Functions
    Functions.fun_21  # Returns: [ 1, 2, 3, 4 ]
    # Note: fun_21 saw first @basic_list declaration when defined
  end

  # IEX Display Redefined Meta Attribute:
  def fun_23 do
    import List, only: :functions
    flatten @basic_list  # Returns: [ 5, 6, 7, 8 ]
    # Note: fun_23 saw second @basic_list declaration when defined
  end

  # IEX Auto-Create Aliases For Module:
  def fun_24 do
    alias F.G.{H, I}
    H.fun_18
  end

  def fun_25 do
    # IEX Capitalized String Is Atom:
    IO.puts is_atom(IO)  # Returns: true

    # IEX Capitalized Strings Location:
    IO.puts :"Elixir.IO" === IO  # Returns: true

    # IEX Use String Instead Of Atom:
    :"Elixir.IO".puts 123  # Returns: 123

    # IEX Use Variable Instead Of Atom:
    my_io = IO
    my_io.puts 123  # Returns: 123
    # Note: Erlang has variables start with uppercase letters
    # Note: Erlang has atoms as simple lowercase names

    # IEX Use Erlang Format:
    IO.puts :io.format("The number is ~3.1f~n", [5.678])  # Returns: 5.7
    # Note: find Erlang libraries on google or github
  end

  # IEX Print Tuple As String:
  def fun_26({ _a, b }) do
    Enum.join(Tuple.to_list({ b }))
  end

  # IEX Swap Tuple Variables:
  def fun_27({ a, b }) do
    { b, a }
  end

  def fun_28 do
    # IEX Quiz (Page 70):
    # Q - Convert a float to a string with two decimal digits. (Erlang):
    # Q - Get the value of an operating-system environment variable. (Elixir):
    # Q - Return the extension component of a file name (so return .exs if given
    #     "dave/test.exs"). (Elixir):
    # Q - Return the process’s current working directory. (Elixir):
    # Q - Convert a string containing JSON into Elixir data structures:
    # Q - Execute a command in your operating system’s shell:

    # IEX Quiz Answers:
    IO.puts :erlang.float_to_binary(123.456, [decimals: 2])
    IO.puts Elixir.System.monotonic_time()
    IO.puts Elixir.Path.extname("dave/test.exs")
    IO.puts fun_26(Elixir.File.cwd)
    # IO.puts JSON.decode("{\"result\":\"this will be an Elixir result\"}")  # Error?
    IO.puts fun_26(fun_27(System.cmd("whoami", [])))
  end
end
