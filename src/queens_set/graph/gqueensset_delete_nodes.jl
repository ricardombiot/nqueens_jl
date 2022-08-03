function delete_node_id!(queens_set :: GQueensSet, node_id_deleting :: NodeId)
    #println("Delete $node_id_deleting")
    node_to_delete = get_node(queens_set, node_id_deleting)
    step = node_to_delete.step

    clean_owners_parents_and_sons_links!(queens_set, node_id_deleting)
    delete_node_of_tables!(queens_set, node_id_deleting, step)

    was_chain_break = checkif_after_delete_node_step_isemty(queens_set,step)
    if was_chain_break
        #println("The chain was break...")
        queens_set.is_valid = false
    end
end

function checkif_after_delete_node_step_isemty(queens_set :: GQueensSet, step :: Step) :: Bool
    return isempty(queens_set.table_lines[step])
end

function delete_node_of_tables!(queens_set :: GQueensSet, node_id_deleting :: NodeId, step :: Step)
    delete!(queens_set.table_nodes, node_id_deleting)
    delete!(queens_set.table_lines[step], node_id_deleting)
end

function clean_owners_parents_and_sons_links!(queens_set :: GQueensSet, node_id_deleting :: NodeId)
    node_to_delete = get_node(queens_set, node_id_deleting)

    for step in 0:queens_set.step-1
        for node_id in queens_set.table_lines[step]
            node_selected = get_node(queens_set, node_id)

            if node_id in node_to_delete.parents
                Nodes.delete_son!(node_selected, node_id_deleting)
            elseif node_id in node_to_delete.sons
                Nodes.delete_parent!(node_selected, node_id_deleting)
            end

            if node_id in node_to_delete.owners
                Nodes.delete_owner!(node_selected, node_id_deleting)
            end
        end
        # This actions can create incoherents, therefore we will be checked during reviewing process.
    end
end

function have_pending_to_remove(queens_set :: GQueensSet) :: Bool
    return !isempty(queens_set.pending_to_remove)
end

function save_to_remove!(queens_set :: GQueensSet, node_id :: NodeId)
    #println("# Save to remove: [$(node_id.action_id)]")
    push!(queens_set.pending_to_remove, node_id)
end

function get_node(queens_set :: GQueensSet, node_id :: NodeId) :: Union{Node,Nothing}
    if haskey(queens_set.table_nodes, node_id)
        return queens_set.table_nodes[node_id]
    else
        return nothing
    end
end
