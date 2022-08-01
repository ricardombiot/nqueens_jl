function test_execution()
    #Init
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = init_timeline(board)
    db = init_db()

    for step in 1:n
        make_step!(step, timeline, db, board)
    end

    cell = Timeline.get_cell(timeline, Color(17))
    DBExecuteAction.execute_cell!(db, cell, board)

    action = DBActions.get_action(db, ActionId(17))
    limit_read = 100
    certificates = IQueensSet.read(action.queens_set, limit_read)
    #println(certificates)
    #println(timeline)
    @test [0,2,8,9,15,17] in certificates
    @test [0,3,5,12,14,17] in certificates
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

function init_db()
    db = DBActions.new()
    seed_queens_set = MockQueensSet.new()
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


test_execution()
