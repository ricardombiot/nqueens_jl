
function init!(queens_set :: GQueensSet)
    step_init = queens_set.step
    action_id_init = ActionId(0)

    node_id = Alias.new_node_id(action_id_init, nothing)
    node_init = Nodes.new(node_id, step_init)

    create_new_line!(queens_set)
    add_node!(queens_set, node_init)

end

function create_new_line!(queens_set :: GQueensSet)
    queens_set.table_lines[queens_set.step] = SetNodesId()
end

function add_node!(queens_set :: GQueensSet, node :: Node)
    push!(queens_set.table_lines[queens_set.step], node.id)
    queens_set.table_nodes[node.id] = node

    queens_set.last_parent_action_id = node.action_id
    queens_set.step += 1
end
