# Execute: c "times.exs"
defmodule Times do
  def double(n) do
    n * 2
  end
  def greet(greeting, name), do: (
    IO.puts greeting
    IO.puts "How're you doing, #{name}?"
  )
  def halve(n), do: n / 2
  def triple(n) do
    n * 3
  end
  def quadruple(n) do
    Times.double(Times.double(n))
  end
end
defmodule Factorial do
  def of(0), do: 1
  def of(n), do: n * of(n-1)
end
defmodule Sum do
  def sum(1), do: 1
  def sum(n), do: n + sum(n-1)
end
defmodule Gcd do
  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y, rem(x,y))
end
defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end
  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end
  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end
end
defmodule Factorial2 do
  def of(0), do: 1
  def of(n) when is_integer(n) and n > 0 do
    n * of(n-1)
  end
end
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
  #def func(p1, p2) do
  #  IO.inspect [p1, p2]
  #end  # Conflicts!
end
defmodule Params do
  def func(p1, p2 \\ 123)
  def func(p1, p2) when is_list(p1) do
    "You said #{p2} with a list"
  end
  def func(p1, p2) do
    "You passed in #{p1} and #{p2}"
  end
  def io_puts do
    IO.puts Params.func(99) # You passed in 99 and 123
    IO.puts Params.func(99, "cat") # You passed in 99 and cat
    IO.puts Params.func([99]) # You said 123 with a list
    IO.puts Params.func([99], "dog") # You said dog with a list
  end
end
defmodule M do
  def guess(guess, min..max) when guess in min..max do
    mid = M.mid_element(min..max)
    if guess == mid do
      IO.puts "We guessed #{mid} (#{min}-#{max}). The answer is #{mid}!"
    else
      #if mid <= min or mid >= max do
      #  IO.puts "We guessed #{mid} (#{min}-#{max}). Infinite loop! Answer was #{guess}."
      #else 
        if guess > mid do
          IO.puts "We guessed #{mid} (#{min}-#{max}). It is too low."
          M.guess(guess, (mid+1)..max)
        else 
          if guess < mid do
            IO.puts "We guessed #{mid} (#{min}-#{max}). It is too high."
            M.guess(guess, min..(mid-1))
          end
        end
      #end
    end
    #IO.inspect a, charlist: false
  end

  def guess(_, _), do: IO.puts "Error: Invalid Inputs."

  def mid_element(min..max) when min != max do 
    list = Enum.to_list min..max
    index = div(Enum.count(list), 2)
    Enum.at(list, index)
  end

  def mid_element(min..max) when min == max, do: min
end
defmodule N do
  defp private_function(a), do: a + 1
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