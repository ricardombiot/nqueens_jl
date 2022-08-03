
function up!(queens_set :: GQueensSet, color :: Color, incompatibles :: Set{Color})
    if queens_set.is_valid
        filter!(queens_set, incompatibles)
        clear_and_review!(queens_set)

        if queens_set.is_valid
            #push new node...
            make_up!(queens_set, color)
        end
    end
end

function filter!(queens_set :: GQueensSet, incompatibles :: Set{Color})
    for step in 0:queens_set.step-1
        for node_id in queens_set.table_lines[step]
            node = get_node(queens_set, node_id)
            if node.color in incompatibles
                save_to_remove!(queens_set, node_id)
            end
        end
    end
end

function clear_and_review!(queens_set :: GQueensSet)
    if queens_set.is_valid
        #println("clear_and_review! $(queens_set.is_valid)")
        clear_nodes!(queens_set)
        review!(queens_set)

        if have_pending_to_remove(queens_set)
            clear_and_review!(queens_set)
        end
    end
end

function clear_nodes!(queens_set :: GQueensSet)
    if queens_set.is_valid
        while !isempty(queens_set.pending_to_remove)
            node_id_deteting = pop!(queens_set.pending_to_remove)
            delete_node_id!(queens_set, node_id_deteting)

            if !queens_set.is_valid
                break
            end
        end
    end
end
