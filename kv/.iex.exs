# Disable if CMD is terminal.

# IEx.configure colors: [ eval_result: [ :cyan, :bright ] ]
# IEx.configure colors: [enabled: true]

# .iex.exs
IEx.configure(inspect: [charlists: :as_lists])
