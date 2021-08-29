# folder -> cmd -> iex -> c "Chapter_1.exs"
# git commit -m "xyz" -> git push -u origin main
Code.compiler_options(ignore_module_conflict: true)

#                   CHAPTER 1
#________________________________________________
#
# result = Parallel.pmap 1..1000, &(&1 * &1)
defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Enum.map(&Task.await/1)
  end
end
#________________________________________________
#
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
