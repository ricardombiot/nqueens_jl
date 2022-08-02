function review!(queens_set :: GQueensSet)
    if queens_set.is_valid
        review_phase_structural!(queens_set)
        review_phase_owners_chain_coherence!(queens_set)
    end
end

function review_phase_structural!(queens_set :: GQueensSet)
    for step in 0:queens_set.step-1
        for node_id in queens_set.table_lines[step]
            node = get_node(queens_set, node_id)

            if !rule_enough_parents(queens_set, node)
                save_to_remove!(queens_set, node_id)
            elseif !rule_enough_sons(queens_set, node)
                save_to_remove!(queens_set, node_id)
            end
        end
    end
end

function review_phase_owners_chain_coherence!(queens_set :: GQueensSet)
    if !have_pending_to_remove(queens_set)
        review_phase_owners_coherence_parents_sons(queens_set)
        review_phase_owners_coherence_sons_parents(queens_set)
        review_phase_each_chain_owners(queens_set)
    end
end

function review_phase_owners_coherence_parents_sons(queens_set :: GQueensSet)
    for step in 1:queens_set.step-1
        for node_id in queens_set.table_lines[step]
            node_selected = get_node(queens_set, node_id)

            union_parents_owners = SetNodesId()
            for parent_id in node_selected.parents
                parent_node = get_node(queens_set, parent_id)
                union!(union_parents_owners, parent_node.owners)
            end

            intersect!(node_selected.owners, union_parents_owners)
            # Importante: In other moment, we will be need check chain owners.
        end
    end
end

function review_phase_owners_coherence_sons_parents(queens_set :: GQueensSet)
    for step in queens_set.step-2:-1:1
        for node_id in queens_set.table_lines[step]
            node_selected = get_node(queens_set, node_id)

            union_sons_owners = SetNodesId()
            for son_id in node_selected.sons
                son_node = get_node(queens_set, son_id)
                union!(union_sons_owners, son_node.owners)
            end

            intersect!(node_selected.owners, union_sons_owners)
            # Importante: In other moment, we will be need check chain owners.
        end
    end
end


function review_phase_each_chain_owners(queens_set :: GQueensSet)
    for step in 0:queens_set.step-1
        for node_id in queens_set.table_lines[step]
            node_selected = get_node(queens_set, node_id)
            #println("CHAIN OWNERS [$(node_id.action_id)]")
            if !rule_valid_node_chain_owners(queens_set, node_selected.owners)
                #println("# Save to remove by chain_owners")
                save_to_remove!(queens_set, node_id)
            end
        end
    end
end

function rule_valid_node_chain_owners(queens_set :: GQueensSet, owners :: SetNodesId) :: Bool
    for step in 0:queens_set.step-1
        nodes_on_step_set = queens_set.table_lines[step]

        owners_on_step = intersect(owners, nodes_on_step_set)
        #println("Step: [$step]")
        #println(Alias.to_txt(nodes_on_step_set))
        #println(Alias.to_txt(owners))
        #println(Alias.to_txt(owners_on_step))

        if isempty(owners_on_step)
            return false
        end
    end

    return true
end

function rule_enough_parents(queens_set :: GQueensSet, node :: Node) :: Bool
    if node.step == 0
        return true
    else
        return !isempty(node.parents)
    end
end

function rule_enough_sons(queens_set :: GQueensSet, node :: Node) :: Bool
    last_step = queens_set.step-1

    if node.step == last_step
        return true
    else
        return !isempty(node.sons)
    end
end
