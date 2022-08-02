
function join!(queens_set_a :: GQueensSet, queens_set_b :: GQueensSet)
    if is_valid_join(queens_set_a, queens_set_b)
        pending_nodes_to_add = join_nodes!(queens_set_a, queens_set_b)
        includes_nodes!(queens_set_a, pending_nodes_to_add)
    end
end

function join_nodes!(queens_set_a :: GQueensSet, queens_set_b :: GQueensSet) :: Array{Node,1}
    pending_nodes_to_add = Array{Node,1}()
    for step in 0:queens_set_b.step-1
        for node_id in queens_set_b.table_lines[step]
            node_b = get_node(queens_set_b, node_id)
            node_a = get_node(queens_set_a, node_id)
            if node_a == nothing
                push!(pending_nodes_to_add, node_b)
            else
                Nodes.join!(node_a, node_b)
            end
        end
    end

    return pending_nodes_to_add
end

function includes_nodes!(queens_set_a :: GQueensSet, pending_nodes_to_add :: Array{Node,1})
    for node in pending_nodes_to_add
        push!(queens_set_a.table_lines[node.step], node.id)
        queens_set_a.table_nodes[node.id] = node
    end
end


function is_valid_join(queens_set_a :: GQueensSet, queens_set_b :: GQueensSet)
    return (queens_set_a.step == queens_set_b.step
            && queens_set_a.last_parent_action_id == queens_set_b.last_parent_action_id
            && queens_set_a.is_valid && queens_set_b.is_valid)
end
