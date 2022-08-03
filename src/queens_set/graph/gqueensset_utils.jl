function get_line_nodes(queens_set :: GQueensSet, step :: Step) :: SetNodesId
    if haskey(queens_set.table_lines, step)
        return queens_set.table_lines[step]
    else
        return SetNodesId()
    end
end

function is_valid(queens_set :: GQueensSet) :: Bool
    return queens_set.is_valid
end

function is_empty(queens_set :: GQueensSet) :: Bool
    return !queens_set.is_valid
end
