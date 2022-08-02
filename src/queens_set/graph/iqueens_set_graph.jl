
  using Main.NQueens.GraphQueensSet: GQueensSet
  using Main.NQueens.GraphQueensSet

  # init!(queens_set_a)

  function init!(queens_set :: GQueensSet)
    GraphQueensSet.init!(queens_set)
  end

  # up!(queens_set_a, color, incompatibles)

  function up!(queens_set :: GQueensSet, color :: Color, incompatibles :: Set{Color})
    GraphQueensSet.up!(queens_set, color, incompatibles)
  end

  # join!(queens_set_a , queens_set_b)
  function join!(queens_set_a :: GQueensSet, queens_set_b :: GQueensSet)
    GraphQueensSet.join!(queens_set_a, queens_set_b)
  end

  # function is_valid(queens_set_a) :: Bool
  function is_valid(queens_set :: GQueensSet) :: Bool
    return GraphQueensSet.is_valid(queens_set)
  end

  # function is_empty(queens_set_a) :: Bool
  function is_empty(queens_set :: GQueensSet) :: Bool
    return GraphQueensSet.is_empty(queens_set)
  end

  function read(queens_set :: GQueensSet, limit :: Int64) :: Array{Array{Color},1}
      throw("READ NOT IMPLEMENTED...")
  end
