module PathExpReader
    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet, NodeId, SetNodesId
    using Main.NQueens.Alias

    using Main.NQueens.GQueensSetComponents.Nodes: Node
    using Main.NQueens.GQueensSetComponents.Nodes

    using Main.NQueens.GraphQueensSet: GQueensSet
    using Main.NQueens.GraphQueensSet

    using Main.NQueens.PathReader: PathSolutionReader
    using Main.NQueens.PathReader

    mutable struct PathSolutionExpReader
        step :: Step
        limit :: Color
        paths_solvers :: Array{PathSolutionReader,1}
        paths_solution :: Array{PathSolutionReader,1}
    end

    include("./reader_path_exp_constructor.jl")
    include("./reader_path_exp_next_step.jl")
    include("./reader_path_exp_getters.jl")

end
