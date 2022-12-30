module NQueens

    include("./utils/alias.jl")

    include("./chessboard_map/chessboard_map.jl")

    include("./timeline/timeline_cell.jl")
    include("./timeline/timeline.jl")
    include("./timeline/timeline_propagation.jl")

    include("./queens_set/mock/mock_queens_secuence.jl")
    include("./queens_set/mock/mock_queens_set.jl")

    include("./queens_set/graph/components/gqueensset_components.jl")
    include("./queens_set/graph/graph_queens_set.jl")
    include("./queens_set/graph/visual/diagram_gqueensset_visual.jl")

    include("./queens_set/graph/reader/reader_path/reader_path.jl")
    include("./queens_set/graph/reader/reader_path_exp/reader_path_exp.jl")

    include("./queens_set/iqueens_set.jl")

    include("./db_actions/actions.jl")
    include("./db_actions/db_actions.jl")
    include("./db_actions/db_execute_action.jl")


    include("./nqueens_machine/instance.jl")
    include("./nqueens_machine/checker.jl")
    include("./nqueens_machine/machine.jl")


end # module
