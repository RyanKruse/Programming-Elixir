IO.puts "Hello, World!"

handle_open = fn
  {:ok, file} -> "First line: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end
IO.puts handle_open.(File.open("hello")) # call with a file that exists
IO.puts handle_open.(File.open("nonexistent")) # and then with one that doesn't

greeter = fn name -> (fn -> "Hello #{name}" end) end
dave_greeter = greeter.("Dave")  # Function
IO.puts dave_greeter.()

greeter = fn name ->"Hello #{name}" end
john_greeter = greeter.("John")  # String
IO.puts john_greeter

add_n = fn n -> (fn other -> n + other end) end
add_five = add_n.(5)
IO.puts add_five.(7)

times_2 = fn n -> n * 2 end
apply = fn (func, input) -> func.(input) end
IO.puts apply.(times_2, 6)

list = [1, 3, 5, 7, 9]  # PDF 60, big MF strange errors.
list2 = Enum.map(list, fn elem -> elem * elem end)
IO.puts list2
#list3 = Enum.map(list, fn elem -> elem > 6 end)
#IO.puts list3

defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_) -> "I don't know you"
    end
  end
end
mr_valim = Greeter.for("Jose", "Oi!")
IO.puts mr_valim.("Jose") # => Oi! Jose
IO.puts mr_valim.("Dave") # => I don't know yo

add_one = &(&1 + 1) # same as add_one = fn (n) -> n + 1 end
square = &(&1 * &1)
speak = &(IO.puts(&1))
IO.puts add_one.(44)
IO.puts square.(8)
IO.puts speak.("Hello")
rnd = &(Float.round(&1, &2))  # Abstracts away.
rnd = &(Float.round(&2, &1))  # Does not abstract away.

divrem = &(div(&1,&2))
IO.puts divrem.(13, 5)
divrem2 = &{ div(&1,&2), rem(&1,&2) }
divrem2.(13, 5)  # Can't IO.puts

s = &"bacon and #{&1}"
IO.puts s.("custard")