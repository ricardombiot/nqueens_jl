function new(queens_set :: GQueensSet) :: PathSolutionReader
    step = Step(0)
    route = Array{Color, 1}()

    action_id_init = ActionId(0)
    node_id_init = Alias.new_node_id(action_id_init, nothing)
    next_node_id = node_id_init

    return PathSolutionReader(step, route, next_node_id, queens_set)
end
