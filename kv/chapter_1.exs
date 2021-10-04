Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_1.exs"
#                   CHAPTER 1
#________________________________________________

# IEX Validate Execution Working:
# result = Parallel.pmap 1..1000, &(&1 * &1)

# Validate Function Working:
defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Enum.map(&Task.await/1)
  end
end

# IEX Helpful Commands:
# 3 + 4
# String.reverse "madamimadam"
# h
# h(IO)
# h IO.puts
# h IEx.configure
# i 123
# i "cat"
# i %{ name: "Dave", likes: "Elixir" }
# i Map
# i :cat
# IO.puts "Hello, World!"
