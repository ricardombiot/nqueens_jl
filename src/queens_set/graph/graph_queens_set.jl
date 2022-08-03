module GraphQueensSet
   using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet, NodeId, SetNodesId
   using Main.NQueens.Alias

   using Main.NQueens.GQueensSetComponents.Nodes: Node
   using Main.NQueens.GQueensSetComponents.Nodes

   mutable struct GQueensSet <: AbstractQueensSet
      n :: Color
      step :: Step
      table_lines :: Dict{Step, SetNodesId}
      table_nodes :: Dict{NodeId, Node}
      last_parent_action_id :: Union{ActionId, Nothing}
      pending_to_remove :: SetNodesId
      is_valid :: Bool
   end

   include("./gqueensset_constructor.jl")
   include("./gqueensset_init.jl")
   include("./gqueensset_delete_nodes.jl")
   include("./gqueensset_review.jl")
   include("./gqueensset_up.jl")
   include("./gqueensset_make_up.jl")
   include("./gqueensset_join.jl")
   include("./gqueensset_delete_nodes.jl")
   include("./gqueensset_utils.jl")

end
