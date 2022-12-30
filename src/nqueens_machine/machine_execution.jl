
function run!(machine :: Machine)
    while !machine.is_finished
        make_step!(machine)

        if machine.step == machine.n+1
            execute_pivot_final!(machine)
            machine.is_finished = true
        end
    end
end

function execute_pivot_final!(machine :: Machine)
    cell = Timeline.get_pivot_end_cell(machine.timeline)
    DBExecuteAction.execute_cell!(machine.db_actions, cell, machine.board)

    action = DBActions.get_action(machine.db_actions, cell.action_id)
    machine.queens_set_solution = action.queens_set
end

function make_step!(machine :: Machine)
    #println("Step: $(machine.step)")

    at_least_one_cell = false
    for col in 1:machine.n
        color = Alias.get_color_cell(machine.n, Color(machine.step), col)
        cell = Timeline.get_cell(machine.timeline, color)

        is_valid_cell = !cell.is_blocked && !isempty(cell.parents)
        if is_valid_cell
            DBExecuteAction.execute_cell!(machine.db_actions, cell, machine.board)
            TimelinePropagation.apply!(machine.timeline, machine.board, color)
            at_least_one_cell = true
        end
    end

    machine.step += 1
    if !at_least_one_cell
        machine.is_finished = true
    end
end
