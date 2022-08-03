
function new(n :: Color) :: GQueensSet
    step = Step(0)
    table_lines = Dict{Step, SetNodesId}()
    table_nodes = Dict{NodeId, Node}()

    last_parent_action_id = nothing
    pending_to_remove = SetNodesId()
    is_valid = true
    GQueensSet(n, step ,table_lines, table_nodes, last_parent_action_id, pending_to_remove, is_valid)
end
