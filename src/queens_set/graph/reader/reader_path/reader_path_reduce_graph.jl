
function reduce_graph!(path :: PathSolutionReader)
    all_nodes_wasnt_selected_save_to_delete!(path)
    GraphQueensSet.clear_and_review!(path.queens_set)

    if !path.queens_set.is_valid
        throw("Grave error...")
    end
end


# Printing debuging with:
#println("[$(path.step)] Remove node in line... $(node_id.key) ")
function all_nodes_wasnt_selected_save_to_delete!(path :: PathSolutionReader)
    #! [for] $ O(N*N) $
    for node_id in GraphQueensSet.get_line_nodes(path.queens_set, path.step)
        if node_id != path.next_node_id
            GraphQueensSet.save_to_remove!(path.queens_set, node_id)
        end
    end
end
