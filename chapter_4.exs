# folder -> cmd -> iex -> c "Chapter_4.exs"
# git commit -m "xyz" -> git push -u origin main
Code.compiler_options(ignore_module_conflict: true)

#                   CHAPTER 4
#________________________________________________
#
# Atoms
# :fred
# :is_binary?
# :var@2
# :<>
# :===
# :"func/3"
# :"long john silver"
# :эликсир

# Ranges
# 1..10

# Regular Expressions
# Regex.run ~r{[aeiou]}, "caterpillar"
# Regex.scan ~r{[aeiou]}, "caterpillar"
# Regex.split ~r{[aeiou]}, "caterpillar"
# Regex.replace ~r{[aeiou]}, "caterpillar", "*"

# Tuples
# { 1, 2 }
# { :ok, 42, "next" }
# { :error, :enoent }
# {status, count, action} = {:ok, 42, "next"}
# { :ok, file } = File.open("chapter_4.exs")
# { :ok, file } = File.open("non-existent")  (error)

# Lists (Command-Line Parameters)
# [1, 2, 3] ++ [4, 5, 6]
# [1, 2, 3, 4] -- [2, 4]
# 1 in [1,2,3,4]
# "wombat" in [1, 2, 3, 4]

# Keyword Lists Conversion
# [ name: "Dave", city: "Dallas", likes: "Programming" ]
# [ {:name, "Dave"}, {:city, "Dallas"}, {:likes, "Programming"} ]
# [1, fred: 1, dave: 2]
# {1, fred: 1, dave: 2}

# Maps (Associative Array)
# states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
# responses = %{ { :error, :enoent } => :fatal, { :error, :busy } => :retry }
# colors = %{ :red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff }
# %{ "one" => 1, :two => 2, {1,1,1} => 3 }
# name = "Jose Valim"
# %{ String.downcase(name) => name }

# Accessing Maps
# states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
# states["AL"]
# states["TX"]
# response_types = %{ { :error, :enoent } => :fatal }+-
# response_types[{:error,:enoent}]
# response_types[{:error,:busy}]
# colors = %{ red: 0xff0000, green: 0x00ff00, blue: 0x0000ff }
# colors[:red]
# colors.green
# colors[:yellow]
# colors.yellow  (error)

# Binaries
# bin = << 1, 2 >>
# byte_size bin

# Dates and Times
# d1 = Date.new(2018, 12, 25)
# {:ok, d1} = Date.new(2018, 12, 25)
# d2 = ~D[2018-12-25]
# d1 == d2
# Date.day_of_week(d1)
# Date.add(d1, 7)
# inspect d1, structs: false

# Range of Dates
# d1 = ~D[2018-01-01]
# d2 = ~D[2018-06-30]
# first_half = Date.range(d1, d2)
# Enum.count(first_half)
# ~D[2018-03-15] in first_half

# Fractional Seconds
# {:ok, t1} = Time.new(12, 34, 56)
# t2 = ~T[12:34:56.78]
# t1 == t2
# Time.add(t1, 3600)
# Time.add(t1, 3600, :millisecond)

# Valid Variables
# name
# josé
# _age
# まつもと_42
# адрес!

# Invalid Variables
# name•
# a±2
# 42

# Truth
# a === b  # strict equality (so 1 === 1.0 is false)
# a !== b  # strict inequality (so 1 !== 1.0 is true)
# a == b  # value equality (so 1 == 1.0 is true)
# a != b  # value inequality (so 1 != 1.0 is false)
# a > b  # normal comparison
# a >= b
# a < b
# a <= b

# Boolean Operators
# a or b  # true if a is true; otherwise b
# a and b  # false if a is false; otherwise b
# not a  # false if a is true; true otherwise
# a || b  # a if a is truthy; otherwise b
# a && b  # b if a is truthy; otherwise a
# !a  # false if a is truthy; otherwise true

# Arithmetic Operators
# + - * /
# div(a, b)  # returns integer.
# rem(a, b)  # returns remainder.

# Join Operators
# binary1 <> binary2  # concatenates two binaries
# list1 ++ list2  # concatenates two lists
# list1 -- list2  # removes elements of list 2 from a copy of list 1

# In Operator
# a in enum  # tests if a is included in enum
# {a, b} in map  # tests if {a, b} is included in map

defmodule Temp do
  # If Block
  def temp_1 do
    line_no = 50
    if (line_no == 50) do
      IO.puts "new-page\f"
    end
  end

  # With Expression
  def temp_2 do
    content = "Now is the time"
    lp =
      with {:ok, file} = File.open("etc/passwd.txt"),
            content = IO.read(file, :all),
            :ok = File.close(file),
            [_, uid, gid] <- Regex.run(~r/^_lp:.*?:(\d+):(\d+)/m, content) do
        "Group: #{gid}, User: #{uid}"
      end
      # => Group: 26, User: 26
      IO.puts(lp)
      # => Now is the time
      IO.puts(content)

      # Match without failing
      with [a|_] <- [1,2,3], do: IO.puts a
      with [a|_] <- nil, do: IO.puts a

      # Function calls
      values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      mean = with count = Enum.count(values),
                  sum = Enum.sum(values),
             do: sum/count
      IO.puts(mean)
  end
end
