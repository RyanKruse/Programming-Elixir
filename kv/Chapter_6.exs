Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_6.exs"
#                   CHAPTER 6
#________________________________________________

defmodule F do
  # IEX Double Input Value:
  def double(n) do
    n * 2
  end

  # IEX Same Syntax Above:
  def double_input(n), do: n * 2

  # IEX Reuse Name And Double 2 Input Values:
  def double(n, m) do
    { double(n), double_input(m) }
  end

  # IEX Multiple Line Function Using Parentheses:
  def greet(greeting, name), do: (
    IO.puts greeting
    IO.puts "How're you doing, #{name}?"
  )

  # IEX Using One-Liners For Simple Functions:
  def halve(n), do: n / 2

  # IEX Quiz (Page 55):
  # Q - Multiply Input Parameters By Three:
  def triple(n) do
    n * 3
  end
  # Q - Reuse Functions Ontop Each Other:
  def quadruple(n) do
    F.double(F.double(n))
  end

  # IEX Factorial Function Using Recursion:
  def factorial(0), do: 1  # Note: base case must occur first, executes top-to-bottom
  def factorial(n), do: n * factorial(n - 1)  # Note: keep same function names together

  # IEX Quiz (Page 57):
  # Q - Calculate Sum Of Integers From 1 To N:
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)

  # Q - Express Greatest Common Divisor Function:
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  # IEX Gaurd Clauses On Number:
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end

  # IEX Gaurd Clauses On List:
  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end

  # IEX Gaurd Clauses On Atom:
  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end

  # IEX Function Of Last Resort:
  def what_is(x) do
    IO.puts "#{x} is unknown"
  end

  # IEX Gaurded Factorial Function:
  def factorial_2(0), do: 1
  def factorial_2(n) when is_integer(n) and n > 0 do
    n * factorial_2(n - 1)
  end

  # Note: page 59 contains all gaurd-clause limitations

  # Functions with default parameters (must have 2 - 4 inputs).
  # Population with 2 inputs: p1, p4.
  # Population with 3 inputs: p1, p2, p4.
  # Population with 4 inputs: p1, p2, p3, p4.
  def default(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end

  # This function never executes; previous function also has 2 inputs.
  #def default(p1, p2) do
  #  IO.inspect [p1, p2]
  #end

  # Default parameter function with no body.
  def parameters(p1, p2 \\ 123)
  def parameters(p1, p2) when is_list(p1), do: "Passed a list and #{p2}"
  def parameters(p1, p2), do: "Passed in #{p1} and #{p2}"
  def io_puts do
    IO.puts F.parameters(99) # Passed in 99 and 123.
    IO.puts F.parameters(99, "cat") # Passed in 99 and cat.
    IO.puts F.parameters([99]) # Passed a list and 123.
    IO.puts F.parameters([99], "dog") # Passed a list and dog.
  end

  # Page 62: Practice Problems. See "defmodule M".

  # Private functions are only callable in module that declared it.
  # Cannot call private() in terminal, but can call call_private.
  defp private(n), do: n + 1
  def call_private(n), do: private(n)


end

defmodule B do
  def func(range) do
    (range) |> Enum.map(&(&1*&1)) |> Enum.filter(&(&1 < 40))
  end
end
defmodule Outer do
  defmodule Inner do
    def inner_func do
    end
  end
  def outer_func do
    Inner.inner_func
  end
end
#Outer.outer_func
#Outer.Inner.inner_func
defmodule Example do
  @basic_list [1,2,3,[4,5],6,7,8,9]
  def func1 do
    List.flatten [1,[2,3],4]
  end
  def func2 do
    import List, only: [flatten: 1]
    flatten [5,[6,7],8]
  end
    def func3 do
    import List, only: :functions
    flatten @basic_list
  end
end
#import List, only: [ flatten: 1, duplicate: 2 ]
defmodule Example2 do
  def compile_and_go(source) do
    alias My.Other.Module.Parser, as: Parser
    alias My.Other.Module.Runner, as: Runner
    # if "as" isn't populated, defaults to last variable.
    # alias My.Other.Module.{Parser, Runner}
    source
    |> Parser.parse()
    |> Runner.execute()
  end
end
defmodule Example3 do
  @attr "one"  # use for metadata, not holding actual variables.
  def first, do: @attr
  @attr "two"
  def second, do: @attr
end
#IO.puts "#{Example.second} #{Example.first}"
#:"Elixir.IO" === IO  # strings are atoms with a dot.
#:"Elixir.IO".puts 123
#:io.format("The number is ~3.1f~n", [5.678])
#:erlang.float_to_binary(123.456, [decimals: 2])
#Elixir.System.monotonic_time()
#Elixir.Path.extname("dave/test.exs")
#Elixir.File.cwd
#decode(bitstring_or_char_list)
#System.cmd("whoami", [])
#[ 1 | [ 2 | [ 3 | [] ] ] ]
#[99, 97, 116]
#[99, 97, 116, 0]
defmodule MyList do
  def len([]), do: 0
  def len([ _head | tail ]), do: 1 + len(tail)

  def square([]), do: []
  def square([ head | tail ]), do: [ head*head | square(tail) ]

  def add_1([]), do: []
  def add_1([ head | tail ]), do: [ head+1 | add_1(tail) ]

  def map([], _func), do: []
  def map([ head | tail ], func), do: [ func.(head) | map(tail, func) ]
end
#MyList.len([1,2,3,4,5])
#MyList.square([1,2,3,4,5])
#MyList.add_1 [4,6,8]
#MyList.map [1,2,3,4], fn (n) -> n*n end
#MyList.map [1,2,3,4], &(&1 > 2)

# Create a binary search function with gaurd clauses.
defmodule M do
  def guess(guess, min..max) when guess in min..max do
    mid = M.mid_element(min..max)
    if guess == mid do
      IO.puts "We guessed #{mid} (#{min}-#{max}). The answer is #{mid}!"
    else
      if guess > mid do
        IO.puts "We guessed #{mid} (#{min}-#{max}). It is too low."
        M.guess(guess, (mid+1)..max)
      else
        if guess < mid do
          IO.puts "We guessed #{mid} (#{min}-#{max}). It is too high."
          M.guess(guess, min..(mid-1))
        end
      end
    end
    #IO.inspect a, charlist: false
  end

  def guess(_, _), do: IO.puts "Error: Invalid Inputs."

  def mid_element(min..max) when min != max do
    list = Enum.to_list min..max
    index = div(Enum.count(list), 2)
    Enum.at(list, index)
  end

  def mid_element(min..max), do: min
end
