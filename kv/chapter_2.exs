Code.compiler_options(ignore_module_conflict: true)
# c "Chapter_2.exs"
#                   CHAPTER 2
#________________________________________________

# IEX Match Operator:
# a = 1
# a + 3
# 1 = a
# 2 = a  # Error: a = 1

# IEX Pattern Matching:
# list = [ 1, 2, 3 ]
# [a, b, c ] = list
# list = [ 1, 2, [ 3, 4, 5 ] ]
# [ a, b, c ] = list
# list = [ 1, 2, 3 ]
# [ a, 2, b ] = list  # Note: a = 1, b = 2
# list = [ 1, 2, 3 ]
# [ a, 1, b ] = list  # Error: 1 != 2

# IEX Quiz (Page 18) - Which of the following will match?:
# a = [ 1, 2, 3 ]  # Match
# a = 4  # Match
# 4 = a  # Match
# [ a, b ] = [ 1, 2, 3 ]  # Error: 3 unmatched
# a = [ [ 1, 2, 3 ] ]  # Match
# [ a ] = [ [ 1, 2, 3 ] ]  # Match
# [ [ a ] ] = [ [ 1, 2, 3 ] ]  # Error: 1 and 3 unmatched

# IEX Ignore Value:
# [ 1, _, _ ] = [ 1, 2, 3 ]
# [ 1, _, _ ] = [ 1, "cat", "dog" ]

# IEX Bind Once:
# [ a, a ] = [ 1, 1 ]
# [ b, b ] = [ 1, 2 ]  # Error: b = 1

# IEX Keep Existing Value:
# a = 1
# a = 2
# ^a = 1  # Error: a = 2
# [ 1, ^a, 3 ] = [ 1, 2, 3 ]
# a = 3
# [ ^a, 2 ] = [ 1, 2 ]  # Error: a = 3

# IEX Quiz (Page 19) - Which of the following will match?:
# [ a, b, a ] = [ 1, 2, 3 ]  # Error: a = 1
# [ a, b, a ] = [ 1, 1, 2 ]  # Error: a = 1
# [ a, b, a ] = [ 1, 2, 1 ]  # Match
# The variable a = 2. Which of the following will match?:
# [ a, b, a ] = [ 1, 2, 3 ]  # Error: a = 1
# [ a, b, a ] = [ 1, 1, 2 ]  # Error: a = 1
# a = 1  # Match
# ^a = 2  # Error: a = 1
# ^a = 1  # Match
# ^a = 2 - a  # Note: 1 = 2 - 1
