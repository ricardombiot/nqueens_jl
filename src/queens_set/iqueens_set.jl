module IQueensSet

    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet
    using Main.NQueens.Alias
    using Main.NQueens.MockQueensSet: MQueensSet
    using Main.NQueens.MockQueensSet

    # init!(queens_set_a)

    function init!(queens_set :: MQueensSet)
      MockQueensSet.init!(queens_set)
    end

    # up!(queens_set_a, color, incompatibles)

    function up!(queens_set :: MQueensSet, color :: Color, incompatibles :: Set{Color})
      MockQueensSet.up!(queens_set, color, incompatibles)
    end

    # join!(queens_set_a , queens_set_b)
    function join!(queens_set_a :: MQueensSet, queens_set_b :: MQueensSet)
      MockQueensSet.join!(queens_set_a, queens_set_b)
    end

    # function is_valid(queens_set_a) :: Bool
    function is_valid(queens_set :: MQueensSet) :: Bool
      return MockQueensSet.is_valid(queens_set)
    end

    # function is_empty(queens_set_a) :: Bool
    function is_empty(queens_set :: MQueensSet) :: Bool
      return MockQueensSet.is_empty(queens_set)
    end

    function read(queens_set :: MQueensSet, limit :: Int64) :: Array{Array{Color},1}
      return MockQueensSet.read(queens_set, limit)
    end

end
