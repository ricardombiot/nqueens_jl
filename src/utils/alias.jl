module Alias

    const Step = Int64
    const Color = Int64
    const ActionId = Int64

    const ActionIdOrNothing = Union{ActionId,Nothing}
    const NodeId = NamedTuple{(:action_id, :parent_action_id),Tuple{ActionId, ActionIdOrNothing}}
    function as_key(node_id :: NodeId) :: String
        parent_id = node_id.parent_action_id
        if node_id.parent_action_id == nothing
            parent_id = "ROOT"
        end
        return "k$(node_id.action_id).$(parent_id)"
    end
    const SetNodesId = Set{NodeId}

    function new_node_id(action_id :: ActionId, parent_action_id :: ActionIdOrNothing) :: NodeId
        node_id :: NodeId = (action_id=action_id, parent_action_id=parent_action_id)
        return node_id
    end

    function to_txt(set_nodes_id :: SetNodesId) :: String
        result = ""
        for node_id in set_nodes_id
            result *= Alias.as_key(node_id)
            result *= ","
        end
        return result
    end


    abstract type AbstractQueensSet end

    function get_color_cell(n :: Color, row_cell :: Color, col_cell :: Color) :: Color
            return (row_cell-1)*n + col_cell
    end

    function get_color_pivot_end_cell(n :: Color) :: Color
        return get_color_cell(n, n, n) + 1
    end

    function get_step_by_color(n :: Color, color :: Color) :: Step
        col_cell = Step(rem(color,n))
        if col_cell == 0
            col_cell = n
        end

        return Step((color-col_cell)/n )+ 1
    end

end
