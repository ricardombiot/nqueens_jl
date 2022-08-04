# Printing debuging with:
#println("[$(path.step)] Selected: $(path.next_node_id.key)")
function fixed_next!(path :: PathSolutionReader)
    node = GraphQueensSet.get_node(path.queens_set, path.next_node_id)
    path.next_node_id = selected_next(path, node)
end

function selected_next(path :: PathSolutionReader, node :: Node) :: Union{NodeId,Nothing}
    is_valid = path.queens_set.is_valid
    have_sons = !isempty(node.sons)

    if is_valid && have_sons
        #Any son should be valid as next_node_id.
        node_id = first(node.sons)
        return node_id
    else
        return nothing
    end
end
