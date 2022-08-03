function test_counting_gqueensset()

    expected_solutions = Dict(4=>2,5=>10,6=>4,7=>40,8=>92,
                              9=>352,10=>724)

    for n in 4:5
        queens_set = test_execution_gqueensset(n)
        read_exp(queens_set)
        total_solutions = PathExpReader.get_total_solutions_found(reader_exp)
        @test total_solutions == expected_solutions[n]
        println("Found solutions $total_solutions on N[$n] - Test: OK")
    end
end

function test_reading_step_by_step(n :: Color)
    queens_set = test_execution_gqueensset(n)
    reader = PathReader.new(queens_set)
    diagram = DiagramGraphQueensSet.build(reader.queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_reading_n$(n)_step_$(reader.step)","./test_visual/reader")

    while PathReader.next_step!(reader)
        #plot
        diagram = DiagramGraphQueensSet.build(reader.queens_set)
        DiagramGraphQueensSet.to_png(diagram, "test_reading_n$(n)_step_$(reader.step)","./test_visual/reader")
    end
    println("Solutions Route:")
    println(reader.route)

end

function test_execution_gqueensset(n :: Color)
    #Init
    #n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = init_timeline(board)
    db = init_db(n)

    for step in 1:n
        make_step!(step, timeline, db, board)
    end

    cell = Timeline.get_pivot_end_cell(timeline)
    DBExecuteAction.execute_cell!(db, cell, board)

    action = DBActions.get_action(db, cell.action_id)


    queens_set = action.queens_set

    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_solution_n$n")

    @test action.queens_set.is_valid
    #reader = read_one(queens_set)
    #println(reader.route)

    return queens_set
end

function read_one(queens_set)
    reader = PathReader.new(queens_set)
    PathReader.calc!(reader)

    return reader
end

function read_exp(queens_set)
    println("--- Reading ---")
    n = queens_set.n
    limit = UInt128(n^n)
    reader_exp = PathExpReader.new(queens_set, limit)
    PathExpReader.calc!(reader_exp)
    txt = PathExpReader.to_string_solutions(reader_exp)

    println(txt)
    println("----------")
    total_solutions = PathExpReader.get_total_solutions_found(reader_exp)
    println("Total: $total_solutions")
    println("----------")

    return reader_exp
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


#test_execution_gqueensset()
#test_counting_gqueensset()
test_reading_step_by_step(7)
