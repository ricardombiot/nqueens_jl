function test_create_timeline()
    n = Color(4)
    timeline = Timeline.new(n)

    Timeline.init!(timeline)

    color = Color(0)
    action_id = ActionId(0)
    for step in 0:n+1
        line_timeline = Timeline.get_step(timeline, step)
        #println("Step [$step]")

        if step == 0 || step == n+1
            cell_pivote = Timeline.secure_get_cell(timeline, step, color)
            @test cell_pivote.step == step
            @test cell_pivote.color == color
            @test cell_pivote.action_id == action_id
            @test cell_pivote.parents == Set{ActionId}()
            color += 1
            action_id += 1
        else
            for col in 1:n
                cell_board = Timeline.secure_get_cell(timeline, step, color)
                @test cell_board.step == step
                @test cell_board.color == color
                @test cell_board.action_id == action_id
                @test cell_board.parents == Set{ActionId}()
                @test cell_board.was_success_executed == false
                color += 1
                action_id += 1
            end

        end

        #println(line_timeline)
        #println("- - - - - - -")
    end


end

function test_init_propagate_timeline()
    #Init
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = Timeline.new(n)
    Timeline.init!(timeline)

    color_init = Color(0)
    action_id_init = ActionId(color_init)
    parent_id_expected = action_id_init


    ## Test
    cell_pivote0 = Timeline.get_cell(timeline, Color(0))
    @test cell_pivote0.was_success_executed == false

    Timeline.success_cell_execution!(timeline, color_init)

    cell_pivote0 = Timeline.get_cell(timeline, Color(0))
    @test cell_pivote0.was_success_executed == true

    #Testing propagation
    TimelinePropagation.apply!(timeline, board, color_init)

    cell_board1 = Timeline.get_cell(timeline, Color(1))
    @test parent_id_expected in cell_board1.parents
    cell_board2 = Timeline.get_cell(timeline, Color(2))
    @test parent_id_expected in cell_board2.parents
    cell_board3 = Timeline.get_cell(timeline, Color(3))
    @test parent_id_expected in cell_board3.parents
    cell_board4 = Timeline.get_cell(timeline, Color(4))
    @test parent_id_expected in cell_board4.parents

end

function test_all_propagations()
    #Init
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    timeline = Timeline.new(n)
    Timeline.init!(timeline)

    # execution...
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

    #testing

    cell_board = Timeline.get_cell(timeline, Color(1))
    @test cell_board.parents == Set([Color(0)])
    cell_board = Timeline.get_cell(timeline, Color(2))
    @test cell_board.parents == Set([Color(0)])
    cell_board = Timeline.get_cell(timeline, Color(3))
    @test cell_board.parents == Set([Color(0)])
    cell_board = Timeline.get_cell(timeline, Color(4))
    @test cell_board.parents == Set([Color(0)])

    cell_board = Timeline.get_cell(timeline, Color(5))
    @test cell_board.parents == Set([Color(3), Color(4)])
    cell_board = Timeline.get_cell(timeline, Color(6))
    @test cell_board.parents == Set([Color(4)])
    cell_board = Timeline.get_cell(timeline, Color(7))
    @test cell_board.parents == Set([Color(1)])
    cell_board = Timeline.get_cell(timeline, Color(8))
    @test cell_board.parents == Set([Color(1), Color(2)])

    cell_board = Timeline.get_cell(timeline, Color(9))
    @test cell_board.parents == Set([Color(7), Color(8)])
    cell_board = Timeline.get_cell(timeline, Color(10))
    @test cell_board.parents == Set([Color(8)])
    cell_board = Timeline.get_cell(timeline, Color(11))
    @test cell_board.parents == Set([Color(5)])
    cell_board = Timeline.get_cell(timeline, Color(12))
    @test cell_board.parents == Set([Color(5), Color(6)])

    cell_board = Timeline.get_cell(timeline, Color(13))
    @test cell_board.parents == Set([Color(11), Color(12)])
    cell_board = Timeline.get_cell(timeline, Color(14))
    @test cell_board.parents == Set([Color(12)])
    cell_board = Timeline.get_cell(timeline, Color(15))
    @test cell_board.parents == Set([Color(9)])
    cell_board = Timeline.get_cell(timeline, Color(16))
    @test cell_board.parents == Set([Color(9), Color(10)])

    cell_pivote_end = Timeline.get_cell(timeline, Color(17))
    # IMPORTANT: We are simulating that always the cell execution is success.
    # Therefore, even we know that the final valid parents are only the 14,15.
    # Think that our test cannot know it, because it only study compatibilities between cells...
    @test cell_pivote_end.parents == Set([Color(13), Color(14), Color(15), Color(16)])

end

test_create_timeline()
test_init_propagate_timeline()
test_all_propagations()
