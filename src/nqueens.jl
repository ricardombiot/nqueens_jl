module NQueens

    include("./utils/alias.jl")

    include("./chessboard_map/chessboard_map.jl")

    include("./timeline/timeline_cell.jl")
    include("./timeline/timeline.jl")
    include("./timeline/timeline_propagation.jl")

    include("./queens_set/mock/mock_queens_secuence.jl")
    include("./queens_set/mock/mock_queens_set.jl")

    include("./queens_set/iqueens_set.jl")

    include("./db_actions/actions.jl")
    include("./db_actions/db_actions.jl")
    include("./db_actions/db_execute_action.jl")



end # module
