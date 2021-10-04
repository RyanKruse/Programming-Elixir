Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_4.exs"
#                   CHAPTER 4
#________________________________________________

# IEX Atoms:
# :fred
# :is_binary?
# :var@2
# :<>
# :===
# :"func/3"
# :"long john silver"

# IEX Ranges:
# 1..10

# IEX Regular Expressions (Space Sensitive):
# Regex.run ~r{[ aeiou ]}, "caterpillar"
# Regex.scan ~r{[ aeiou ]}, "caterpillar"
# Regex.split ~r{[ aeiou ]}, "caterpillar"
# Regex.replace ~r{[ aeiou ]}, "caterpillar", "*"

# IEX Tuples:
# { 1, 2 }
# { :ok, 42, "next" }
# { :error, :enoent }
# { status, count, action } = { :ok, 42, "next" }
# { :ok, file } = File.open("chapter_4.exs")
# { :ok, file } = File.open("non-existent.exs")  # Error: :ok != :error

# IEX Lists (Command-Line Parameters):
# [1, 2, 3] ++ [4, 5, 6]  # Note: join
# [1, 2, 3, 4] -- [2, 4]  # Note: remove
# 1 in [ 1, 2, 3, 4 ]  # Note: contains
# "wombat" in [ 1, 2, 3, 4 ]

# IEX Keyword Lists Conversion:
# [ name: "Dave", city: "Dallas", likes: "Programming" ]
# [ { :name, "Dave" }, { :city, "Dallas" }, { :likes, "Programming" } ]  # Note: converts to above
# [ 1, { :fred, 1 }, { :dave, 2 } ]
# [ 1, fred: 1, dave: 2 ]  # Note: converts to above
# { 1, [ fred: 1, dave: 2 ] }
# { 1, fred: 1, dave: 2 }  # Note: converts to above

# IEX Maps (Associative Array):
# states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
# responses = %{ { :error, :enoent } => :fatal, { :error, :busy } => :retry }
# colors = %{ :red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff }
# %{ "one" => 1, :two => 2, { 1, 1, 1 } => 3 }
# name = "Jose Valim"
# %{ String.downcase(name) => name }

# IEX Accessing Maps:
# states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
# states[ "AL" ]  # Returns: "Alabama"
# states[ "TX" ]  # Returns: nil
# response_types = %{ { :error, :enoent } => :fatal }
# response_types[ { :error, :enoent } ]  # Returns: :fatal
# response_types[ { :error, :busy } ]  # Returns: nil
# colors = %{ red: 0xff0000, green: 0x00ff00, blue: 0x0000ff }
# colors[ :red ]  # Returns: 16711680
# colors.green  # Returns: 65280
# colors[ :yellow ]  # Returns: nil
# colors.yellow  # Error: key not found

# IEX Binaries:
# bin = << 1, 2 >>
# byte_size bin  # Returns: 2

# IEX Dates and Times:
# d1 = Date.new(2018, 12, 25)
# { :ok, d1 } = Date.new(2018, 12, 25)
# d2 = ~D[2018-12-25]  # Note: space sensitive
# d1 == d2  # Returns: true
# Date.day_of_week(d1)
# Date.add(d1, 7)
# inspect d1, structs: false
# d1 == d2  # Returns: true

# IEX Range of Dates:
# d1 = ~D[2018-01-01]
# d2 = ~D[2018-06-30]
# first_half = Date.range(d1, d2)
# Enum.count(first_half)  # Returns: 181
# ~D[2018-03-15] in first_half  # Returns: true

# IEX Fractional Seconds:
# { :ok, t1 } = Time.new(12, 34, 56, 78)
# t2 = ~T[12:34:56.78]
# t1 == t2  # Returns: false
# { :ok, t1 } = Time.new(12, 34, 56, 780000)
# t1 == t2  # Returns: false
# t2 = ~T[12:34:56.780000]
# t1 == t2  # Returns: true
# Time.add(t1, 3600)  # Note: adds 1 hour
# Time.add(t1, 3600, :millisecond)  # Note: adds 4 seconds

# IEX Valid Variables (Not CMD Friendly):
# name
# josé
# _age
# まつもと_42
# адрес!

# IEX Invalid Variables (Not CMD Friendly):
# name•  # Error: ! and ? identifiers endings only
# a±2  # Error: operator
# 42  # Error: operand

# IEX Truth Statements:
# a === b  # Note: strict equality (so 1 === 1.0 is false)
# a !== b  # Note: strict inequality (so 1 !== 1.0 is true)
# a == b  # Note: value equality (so 1 == 1.0 is true)
# a != b  # Note: value inequality (so 1 != 1.0 is false)
# a > b  # Note: value comparison
# a >= b
# a < b
# a <= b

# IEX Boolean Operators:
# a or b  # Note: true if a is true; otherwise b
# a and b  # Note: false if a is false; otherwise b
# not a  # Note: false if a is true; true otherwise
# a || b  # Note: a if a is truthy; otherwise b
# a && b  # Note: b if a is truthy; otherwise a
# !a  # Note: false if a is truthy; otherwise true

# IEX Arithmetic Operators:
# + - * /
# div(a, b)  # Note: returns an integer.
# rem(a, b)  # Note: returns the remainder.

# IEX Join Operators:
# binary1 <> binary2  # Note: joins two binaries
# list1 ++ list2  # Note: joins two lists
# list1 -- list2  # Note: removes elements of list 2 from a copy of list 1

# IEX In Operator (Enum):
# a in enum  # Note: check if a is included in enum
# list = [ 1, 2, 3]
# 1 in list  # Returns: true
# a = 1
# a in list  # Returns: true

# IEX In Operator (Map):
# { a, b } in map  # Note: check if { a, b } is included in map
# states = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
# { "AL" } in states  # Returns: false
# { "AL", "WI" } in states  # Returns: false
# { "AL", "Alabama" } in states  # Returns: true

# IEX Function Executions (F.fun_1):
defmodule F do
  def fun_1 do
    # IEX If-Else Expression:
    line_no = :rand.uniform(3)
    header = "line_no = #{line_no} |"
    if (line_no === 1) do
      IO.puts "#{header} new-page\n"
    else if (line_no === 2) do
      IO.puts "#{header} double-page\n\n"
    else
      IO.puts "#{header} many-pages\n\n\n"
    end
    end
  end

  def fun_2 do
    # IEX With Expression:
    content = "Now is the time"
    identification =
      with { :ok, file } = File.open("etc/password.txt"),
        content = IO.read(file, :all),
        :ok = File.close(file),
        [ _, uid, gid ] <- Regex.run(~r/^_lp:.*?:(\d+):(\d+)/m, content) do
          "Group: #{gid}, User: #{uid}"
        end  # Note: content variable restored to original value
    IO.puts(identification)  # Returns: Group: 26, User: 26
    IO.puts(content)  # Returns: Now is the time

    # IEX Match Without Failing:
    with [ a | _ ] <- [ 1, 2, 3 ], do: IO.puts a  # Returns: 1
    with [ a | _ ] <- nil, do: IO.puts a  # Returns: nil

    # IEX Function Calls:
    values = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
    mean =
      with count = Enum.count(values),
      sum = Enum.sum(values),
      do: sum / count
    IO.puts(mean)
  end
end
