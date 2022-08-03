
function calc!(path :: PathSolutionReader)
    #! [recursive-if] $ O(N) $
    if next_step!(path)
        calc!(path)
    end
end

function next_step!(path :: PathSolutionReader) :: Bool
    is_finished = path.next_node_id == nothing
    if !is_finished
        push_step!(path)
        fixed_next!(path)
        reduce_graph!(path)
        return true
    else
        return false
    end
end

# Printing debuging with:
#println("[$(path.step)] Push step: $(path.next_node_id.key) ($(node.color))")
function push_step!(path :: PathSolutionReader)
    node = GraphQueensSet.get_node(path.queens_set, path.next_node_id)
    push!(path.route, node.color)

    path.step += 1
end
