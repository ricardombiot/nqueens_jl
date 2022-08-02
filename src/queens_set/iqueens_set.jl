module IQueensSet
    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet
    using Main.NQueens.Alias
    # init!(queens_set_a)
    # up!(queens_set_a, color, incompatibles)
    # join!(queens_set_a , queens_set_b)
    # function is_valid(queens_set_a) :: Bool
    # function is_empty(queens_set_a) :: Bool

    include("./mock/iqueens_set_mock.jl")
    include("./graph/iqueens_set_graph.jl")

end
