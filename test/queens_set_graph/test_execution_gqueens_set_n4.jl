function test_execution_gqueensset()
    #Init
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = init_timeline(board)
    db = init_db(n)

    for step in 1:n
        make_step!(step, timeline, db, board)
    end

    cell = Timeline.get_cell(timeline, Color(17))
    DBExecuteAction.execute_cell!(db, cell, board)

    action = DBActions.get_action(db, ActionId(17))
    @test action.queens_set.is_valid

    queens_set = action.queens_set

    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_solution_n4")
end

function make_step!(step, timeline, db, board)
    for col in 1:board.n

        color = Alias.get_color_cell(board.n, Color(step), col)
        #println("($step, $col) => $color")
        cell = Timeline.get_cell(timeline, color)

        DBExecuteAction.execute_cell!(db, cell, board)
        TimelinePropagation.apply!(timeline, board, color)
    end
end

function init_db(n)
    db = DBActions.new()
    seed_queens_set = GraphQueensSet.new(n)
    DBActions.init!(db, seed_queens_set)

    return db
end

function init_timeline(board)
    timeline = Timeline.new(board.n)
    Timeline.init!(timeline)
    color = Color(0)
    action_id = ActionId(color)
    Timeline.success_cell_execution!(timeline, color)
    TimelinePropagation.apply!(timeline, board, color)

    return timeline
end


test_execution_gqueensset()
