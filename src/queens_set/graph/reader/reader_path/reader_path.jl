module PathReader
    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet, NodeId, SetNodesId
    using Main.NQueens.Alias

    using Main.NQueens.GQueensSetComponents.Nodes: Node
    using Main.NQueens.GQueensSetComponents.Nodes

    using Main.NQueens.GraphQueensSet: GQueensSet
    using Main.NQueens.GraphQueensSet

    mutable struct PathSolutionReader
        step :: Step
        route :: Array{Color, 1}
        next_node_id :: Union{NodeId, Nothing}
        queens_set :: GQueensSet
    end

    include("./reader_path_constructor.jl")
    include("./reader_path_next_step.jl")
    include("./reader_path_selection.jl")
    include("./reader_path_reduce_graph.jl")
    include("./reader_path_getters.jl")


end
