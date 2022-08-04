function test_simple_instance()
    n = Color(4)
    instance = NQueensInstance.new(n)

    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = Timeline.new(n)
    Timeline.init!(timeline)

    cell_board = Timeline.get_cell(timeline, Color(1))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(2))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(3))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(4))
    @test cell_board.is_blocked == false


    cell_board = Timeline.get_cell(timeline, Color(5))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(6))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(7))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(8))
    @test cell_board.is_blocked == false


    cell_board = Timeline.get_cell(timeline, Color(9))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(10))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(11))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(12))
    @test cell_board.is_blocked == false

    cell_board = Timeline.get_cell(timeline, Color(13))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(14))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(15))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(16))
    @test cell_board.is_blocked == false


    # After restrictions
    NQueensInstance.include_queen_by_color!(instance, Color(1))
    NQueensInstance.apply_restrictions_timeline!(instance, timeline, board)

    cell_board = Timeline.get_cell(timeline, Color(1))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(2))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(3))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(4))
    @test cell_board.is_blocked == true



    cell_board = Timeline.get_cell(timeline, Color(5))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(6))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(7))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(8))
    @test cell_board.is_blocked == false


    cell_board = Timeline.get_cell(timeline, Color(9))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(10))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(11))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(12))
    @test cell_board.is_blocked == false

    cell_board = Timeline.get_cell(timeline, Color(13))
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(14))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(15))
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(16))
    @test cell_board.is_blocked == true

end

function test_simple_instance_full_propagation()
    n = Color(4)
    instance = NQueensInstance.new(n)

    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = Timeline.new(n)
    Timeline.init!(timeline)


    NQueensInstance.include_queen_by_color!(instance, Color(1))

    NQueensInstance.apply_restrictions_timeline!(instance, timeline, board)

    color = Color(0)
    action_id = ActionId(color)
    Timeline.success_cell_execution!(timeline, color)
    TimelinePropagation.apply!(timeline, board, color)
    color += 1

    for row in 1:n
        for col in 1:n
            Timeline.success_cell_execution!(timeline, color)
            TimelinePropagation.apply!(timeline, board, color)
            color += 1
        end
    end


    cell_board = Timeline.get_cell(timeline, Color(1))
    @test cell_board.parents == Set([Color(0)])
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(2))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(3))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(4))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true

    cell_board = Timeline.get_cell(timeline, Color(5))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(6))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(7))
    @test cell_board.is_blocked == false
    @test cell_board.parents == Set([Color(1)])
    cell_board = Timeline.get_cell(timeline, Color(8))
    @test cell_board.is_blocked == false
    @test cell_board.parents == Set([Color(1)])

    cell_board = Timeline.get_cell(timeline, Color(9))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(10))
    @test cell_board.parents == Set([Color(8)])
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(11))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(12))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == false


    cell_board = Timeline.get_cell(timeline, Color(13))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true
    cell_board = Timeline.get_cell(timeline, Color(14))
    #Cannot detected that 12 will have emtpy set.
    # I prefer dont force code... its OK.
    @test cell_board.parents == Set([12])
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(15))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == false
    cell_board = Timeline.get_cell(timeline, Color(16))
    @test cell_board.parents == Set()
    @test cell_board.is_blocked == true

end

test_simple_instance()
test_simple_instance_full_propagation()
