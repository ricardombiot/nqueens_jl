function make_up!(queens_set :: GQueensSet, color :: Color)
    if queens_set.is_valid
        step = queens_set.step
        action_id = ActionId(color)

        node_id = Alias.new_node_id(action_id, queens_set.last_parent_action_id)
        node_new = Nodes.new(node_id, queens_set.step)

        create_new_line!(queens_set)
        add_node!(queens_set, node_new)

        connect_with_parents!(queens_set, node_new)
        fixed_as_owners_of_all!(queens_set, node_new)
    end
end

function connect_with_parents!(queens_set :: GQueensSet, node_new :: Node)
    for node_id in queens_set.table_lines[queens_set.step-2]
        node_parent = get_node(queens_set, node_id)

        Nodes.add_parent!(node_new, node_parent)
        Nodes.add_son!(node_parent, node_new)
    end
end

function fixed_as_owners_of_all!(queens_set :: GQueensSet, node_new :: Node)
    for step in 0:queens_set.step-2
        for node_id in queens_set.table_lines[step]
            node_selected = get_node(queens_set, node_id)
            Nodes.build_owner_link!(node_new, node_selected)
        end
    end
end
