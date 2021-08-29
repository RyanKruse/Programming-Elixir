# folder -> cmd -> iex -> c "Chapter_2.exs"
# git commit -m "xyz" -> git push -u origin main
Code.compiler_options(ignore_module_conflict: true)

#                   CHAPTER 2
#________________________________________________
#
# Match Operator
# a = 1
# a + 3
# 1 = a
# 2 = a  (error)

# Pattern Matching
# list = [ 1, 2, 3 ]
# [a, b, c ] = list
# list = [1, 2, [ 3, 4, 5 ] ]
# [a, b, c ] = list
# list = [1, 2, 3]
# [a, 2, b ] = list  (b=2)
# list = [1, 2, 3]
# [a, 1, b ] = list  (error)

# Quiz (p.18)
# "Which of the following will match?"
# a = [1, 2, 3]
# a = 4
# 4 = a
# [a, b] = [ 1, 2, 3 ]  (error)
# a = [ [ 1, 2, 3 ] ]
# [a] = [ [ 1, 2, 3 ] ]
# [[a]] = [ [ 1, 2, 3 ] ]  (error)

# Ignore Value
# [1, _, _] = [1, 2, 3]
# [1, _, _] = [1, "cat", "dog"]

# Bind Once
# [a, a] = [1, 1]
# [b, b] = [1, 2]  (error)

# Keep Existing Value
# a = 1
# ^a = 2  (error)
# [^a, 2, 3 ] = [ 1, 2, 3 ]
# a = 2
# [ ^a, 2 ] = [ 1, 2 ]  (error)

# Quiz (p.19)
# "Which of the following will match?"
# [ a, b, a ] = [ 1, 2, 3 ]  (error)
# [ a, b, a ] = [ 1, 1, 2 ]  (error)
# [ a, b, a ] = [ 1, 2, 1 ]
# "The variable a is bound to the value 2. Which of the following will match?"
# [ a, b, a ] = [ 1, 2, 3 ]  (error)
# [ a, b, a ] = [ 1, 1, 2 ]  (error)
# a = 1
# ^a = 2  (error)
# ^a = 1
# ^a = 2 - a
