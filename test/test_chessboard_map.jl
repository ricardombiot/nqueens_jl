function test_create_chessboard_map_n4()
    n = Color(4)
    board = Chessboard.new(n)

    color = 1
    for row in 1:n
        for col in 1:n
            @test row == Alias.get_step_by_color(n, color)

            color_cell = Chessboard.get_color_cell(n, row, col)
            #println("$color , $n $color_cell")
            @test color_cell in board.all_colors
            color +=1
        end
    end

    Chessboard.build!(board)

    @test board.table_compatibilities[Color(1)] == Set([1,7,8,10,12,14,15])
    @test board.table_compatibilities[Color(2)] == Set([2,8,9,11,13,15,16])
    @test board.table_compatibilities[Color(3)] == Set([3,5,10,12,13,14,16])
    @test board.table_compatibilities[Color(4)] == Set([4,5,6,9,11,14,15])

    @test board.table_compatibilities[Color(5)] == Set([3,4,5,11,12,14,16])
    @test board.table_compatibilities[Color(6)] == Set([4,6,12,13,15])
    @test board.table_compatibilities[Color(7)] == Set([1,7,9,14,16])
    @test board.table_compatibilities[Color(8)] == Set([1,2,8,9,10,13,15])

    @test board.table_compatibilities[Color(9)] == Set([2,4,7,8,9,15,16])
    @test board.table_compatibilities[Color(10)] == Set([1,3,8,10,16])
    @test board.table_compatibilities[Color(11)] == Set([2,4,5,11,13])
    @test board.table_compatibilities[Color(12)] == Set([1,3,5,6,12,13,14])

    @test board.table_compatibilities[Color(13)] == Set([2,3,6,8,11,12,13])
    @test board.table_compatibilities[Color(14)] == Set([1,3,4,5,7,12,14])
    @test board.table_compatibilities[Color(15)] == Set([1,2,4,6,8,9,15])
    @test board.table_compatibilities[Color(16)] == Set([2,3,5,7,9,10,16])
    #println(board)
end


test_create_chessboard_map_n4()
