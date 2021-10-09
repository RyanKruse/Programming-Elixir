Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_7.exs"
#                   CHAPTER 7
#________________________________________________

# ----------------- UNFORMATTED CODE --------------------- #

defmodule A do
  # Keyword Lists
  @defaults [ fg: "black", bg: "white", font: "Merriweather" ]
  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)
    IO.puts "Drawing text #{inspect(text)}"
    IO.puts "Foreground: #{options[:fg]}"
    IO.puts "Background: #{Keyword.get(options, :bg)}"
    IO.puts "Font: #{Keyword.get(options, :font)}"
    IO.puts "Pattern: #{Keyword.get(options, :pattern, "solid")}"
    IO.puts "Style: #{inspect Keyword.get_values(options, :style)}"
  end
  # IEX Input: A.draw_text("hello", fg: "red", style: "italic", style: "bold")
  # Keyword and Enum modules can also be applied.

  # Maps
  # map = %{ name: "Dave", likes: "Programming", where: "Dallas" }
  # Map.keys map
  # Map.values map
  # map[:name]
  # map.name
  # map1 = Map.drop map, [:where, :likes]
  # map2 = Map.put map, :also_likes, "Ruby"
  # Map.keys map2
  # Map.has_key? map1, :where
  # { value, updated_map } = Map.pop map2, :also_likes
  # Map.equal? map, updated_map

  # Complex Maps
  # person = %{ name: "Dave", height: 1.88 }
  # %{ name: a_name } = person
  # a_name
  # %{ name: _, height: _ } = person
  # %{ name: "Dave" } = person
  # %{ name: _, weight: _ } = person  # Error: no match found

  # More Map Complexity (single-line for-loop within a list of maps)
  _people = [
    %{ name: "Grumpy", height: 1.24 },
    %{ name: "Dave", height: 1.88 },
    %{ name: "Dopey", height: 1.32 },
    %{ name: "Shaquille", height: 2.16 },
    %{ name: "Sneezy", height: 1.28 }
    ]
  # for person = %{ height: height } <- people, height > 1.5, do: person
  # Note: binds each map to person (from people), restrict height and output person.
end

defmodule HotelRoom do
  def book(%{name: name, height: height})
    when height > 1.9 do
      IO.puts "Need extra-long bed for #{name}"
  end
  def book(%{name: name, height: height})
    when height < 1.3 do
    IO.puts "Need low shower controls for #{name}"
  end
  def book(person) do
    IO.puts "Need regular bed for #{person.name}"
  end
end
# people |> Enum.each(&HotelRoom.book/1)
# Returns: Loops through each map in list and tries to match one of the defs.
# This could be super simplified with cond ... end statement

# Bind value through pattern matching:
# %{ 2 => state } = %{ 1 => :ok, 2 => :error }
# Returns: %{ 1 => :ok, 2 => :error }

# Cannot bind keys through pattern matching:
# %{ item => :ok } = %{ 1 => :ok, 2 => :error }  # Error.

# For-loop of map to pattern match keys:
data = %{ name: "Dave", state: "TX", likes: "Elixir" }
for key <- [ :name, :likes ] do
  %{ ^key => value } = data
  value
end
# Returns: [ "Dave", "Elixir" ]

# Updating a Map (Cannot add new key)
# Syntax: new_map = %{ old_map | key => value, … }
# m = %{ a: 1, b: 2, c: 3 }
# Returns: %{a: 1, b: 2, c: 3}
# m1 = %{ m | b: "two", c: "three" }
# Returns: %{a: 1, b: "two", c: "three"}
# m2 = %{ m1 | a: "one" }
# Returns: %{a: "one", b: "two", c: "three"}

# Add key to map
# Map.put_new/3

# Names of module becomes the map itself.
# Structs have no access to Dict capabilities.
defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end
# s1 = %Subscriber{}
# Returns: %Subscriber{name: "", over_18: true, paid: false}
# s2 = %Subscriber{ name: "Dave" }
# Returns: %Subscriber{name: "Dave", over_18: true, paid: false}
# s3 = %Subscriber{ name: "Mary", paid: true }
# Returns: %Subscriber{name: "Mary", over_18: true, paid: true}

# Access fields in a struct:
# s3.name
# Returns: "Mary"
# %Subscriber{name: a_name} = s3
# Returns: %Subscriber{name: "Mary", over_18: true, paid: true}
# a_name
# Returns: "Mary"

# Use updates on structs:
# s4 = %Subscriber{ s3 | name: "Marie"}
# Returns: %Subscriber{name: "Marie", over_18: true, paid: true}

# Add Struct-Specific Behavior:
defmodule Attendee do
  defstruct name: "", paid: false, over_18: true
  def may_attend_after_party(attendee = %Attendee{}) do
    attendee.paid && attendee.over_18
  end
  def print_vip_badge(%Attendee{name: name}) when name != "" do
    IO.puts "Very cheap badge for #{name}"
  end
  def print_vip_badge(%Attendee{}) do
    raise "missing name for badge"
  end
end
# a1 = %Attendee{name: "Dave", over_18: true}
# Returns: %Attendee{name: "Dave", over_18: true, paid: false}
# Attendee.may_attend_after_party(a1)
# Returns: false

# a2 = %Attendee{a1 | paid: true}
# Returns: %Attendee{name: "Dave", over_18: true, paid: true}
# Attendee.may_attend_after_party(a2)
# Returns: true
# Attendee.print_vip_badge(a2)
# Returns: Very cheap

# a3 = %Attendee{}
# Returns: %Attendee{name: "", over_18: true, paid: false}
# Attendee.print_vip_badge(a3)
# Error: (RuntimeError) missing name for badge…

# Nested Dictionary Structures (Map in Map):
defmodule Customer do
  defstruct name: "", company: ""
end
defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end

# Note: only values can contain maps; keys must be atoms
# report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
# Returns: Dictionary created
# report.owner.company
# Returns: "Pragmatic"

# Set value in a nested structure:
# report = put_in(report.owner.company, "PragProg")
# report.owner.company
# Returns: report with correct company name

# Apply a funtion in a nested structure:
# report = update_in(report.owner.name, &("Mr. " <> &1))
# report.owner.name
# Returns: report with updated name prefix

# Nested Accessors and Nonstructs:
# report = %{ owner: %{ name: "Dave", company: "Pragmatic" }, severity: 1}
# Returns: %{owner: %{company: "Pragmatic", name: "Dave"}, severity: 1}
# report = put_in(report[:owner][:company], "PragProg")
# Returns: %{owner: %{company: "PragProg", name: "Dave"}, severity: 1}
# report = update_in(report[:owner][:name], &("Mr. " <> &1))
# Returns: %{owner: %{company: "Pragmatic", name: "Mr. Dave"}, severity: 1}

# Dynamic (Runtime) Nested Accessors:
# Note: The number of keys you pass a particular call is static.
# Note: You can’t pass the set of keys as parameters between functions.
#
#                   Macro          Function
# get_in            no             (dict, keys)
# put_in            (path, value)  (dict, keys, value)
# update_in         (path, fn)     (dict, keys, fn)
# get_and_update_in (path, fn)     (dict, keys, fn)

# IEX Input:
nested = %{
  buttercup: %{
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
  },
  westley: %{
    actor: %{
      first: "Cary",
      last: "Elwes" # typo!
    },
    role: "farm boy"
  }
}
# WARNING: May need to use IO.inspect instead of IO.puts for displaying tuples...
# get_in(nested, [:buttercup])
# Returns: %{actor: %{first: "Robin", last: "Wright"}, role: "princess"}
# get_in(nested, [:buttercup, :actor])
# Returns: %{first: "Robin", last: "Wright"}
# get_in(nested, [:buttercup, :actor, :first])
# Returns: "Robin"
# nested = put_in(nested, [:westley, :actor, :last], "Elvis")
# Returns: %{buttercup: %{actor: %{first: "Robin", last: "Wright"}, role: "princess"},
#          westley: %{actor: %{first: "Cary", last: "Elvis"}, role: "farm boy"}}

# IEX Input (Complex Example):
authors = [
  %{ name: "Jose", language: "Elixir" },
  %{ name: "Matz", language: "Ruby" },
  %{ name: "Larry", language: "Perl" }
]

languages_with_an_r = fn (:get, collection, next_fn) ->
  for row <- collection do
    if String.contains?(row.language, "r") do
      next_fn.(row)
    end
  end
end

# get_in(authors, [languages_with_an_r, :name])
# Returns: [ "José", nil, "Larry" ]  # Note: lower case 'r' check only

# Access Module:
# Note: Access is basically a drill to a specific element in nested data structures
cast = [
  %{
    character: "Buttercup",
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
  },
  %{
    character: "Westley",
    actor: %{
      first: "Cary",
      last: "Elwes"
    },
    role: "farm boy"
  }
]
# get_in(cast, [Access.all(), :character])
# Returns: ["Buttercup", "Westley"]
# get_in(cast, [Access.at(1), :role])
# Returns: "farm boy"
# cast = get_and_update_in(cast, [Access.all(), :actor, :last], fn (val) -> {val, String.upcase(val)} end)
# Returns: cast with the last name all uppercase.

# Access.Elem Function:
cast = [
  %{
    character: "Buttercup",
    actor: {"Robin", "Wright"},
    role: "princess"
  },
  %{
    character: "Westley",
    actor: {"Carey", "Elwes"},
    role: "farm boy"
  }
]
# get_in(cast, [Access.all(), :actor, Access.elem(1)])
# Returns: ["Wright", "Elwes"]
# cast = get_and_update_in(cast, [Access.all(), :actor, Access.elem(1)], fn (val) -> {val, String.reverse(val)} end)
# Returns: cast with the last name all reversed.

# Access.Key Function:
cast = %{
  buttercup: %{
    actor: {"Robin", "Wright"},
    role: "princess"
  },
  westley: %{
    actor: {"Carey", "Elwes"},
    role: "farm boy"
  }
}
# get_in(cast, [Access.key(:westley), :actor, Access.elem(1)])
# Returns: "Elwes"
# get_and_update_in(cast, [Access.key(:buttercup), :role], fn (val) -> {val, "Queen"} end)
# Returns: Buttercup's role changes from pricess to Queen

# Access.Pop Function:
# Note: Returns value of key and updated container
# Access.pop(%{name: "Elixir", creator: "Valim"}, :name)
# Return: {"Elixir", %{creator: "Valim"}}
# Access.pop([name: "Elixir", creator: "Valim"], :name)
# Return: {"Elixir", [creator: "Valim"]}
# Access.pop(%{name: "Elixir", creator: "Valim"}, :year)
# Return: {nil, %{creator: "Valim", name: "Elixir"}}

# Sets Using MapSet:
# set1 = 1..5 |> Enum.into(MapSet.new)
# Returns: #MapSet<[1, 2, 3, 4, 5]>
# set2 = 3..8 |> Enum.into(MapSet.new)
# Returns: #MapSet<[3, 4, 5, 6, 7, 8]>
# MapSet.member? set1, 3
# Returns: true
# MapSet.union set1, set2
# Returns: #MapSet<[1, 2, 3, 4, 5, 6, 7, 8]>
# MapSet.difference set1, set2
# Returns: #MapSet<[1, 2]>
# MapSet.difference set2, set1
# Returns: #MapSet<[6, 7, 8]>
# MapSet.intersection set2, set1
# Returns: #MapSet<[3, 4, 5]>



# Stop Page 87
# Maps -> Enums/Streams/Comprehension -> Strings/Binaries -> if/cond/case/exceptions
# -> project/github/libraries/transformation -> debugging/testing/tools/dependencies

# Concurrent Programming (wtf) ... -> Nodes -> OTP -> Supervisors -> Complex Example
# -> Applications -> Tasks and Agents

# Ultra Mega Clearance... -> Macros/Evaluation -> Linking Modules -> Protocols -> Misc
# -> Exceptions -> Type Specifications/Checking ->
