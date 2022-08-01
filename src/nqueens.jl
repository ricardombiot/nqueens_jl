module NQueens

    include("./utils/alias.jl")

    include("./chessboard_map/chessboard_map.jl")
    include("./timeline/timeline_cell.jl")
    include("./timeline/timeline.jl")
    include("./timeline/timeline_propagation.jl")

end # module
