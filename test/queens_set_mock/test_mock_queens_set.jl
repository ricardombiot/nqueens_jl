function test_simulate_derivion_of_secuence()
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)

    secuence = MockQueensSecuences.seed()

    incompatibles = Chessboard.get_color_incompatibles(board, Color(1))
    secuence = MockQueensSecuences.derive_or_nothing(secuence, Color(1), incompatibles)

    @test secuence.positions == [0,1]
    @test secuence.colors_used == Set([0,1])

    incompatibles = Chessboard.get_color_incompatibles(board, Color(7))
    secuence = MockQueensSecuences.derive_or_nothing(secuence, Color(7), incompatibles)

    @test secuence.positions == [0,1,7]
    @test secuence.colors_used == Set([0,1,7])

    # Color(9) is incompatible with Color(1) then next step to 9 es invalid.
    secuence_invalid = deepcopy(secuence)
    incompatibles = Chessboard.get_color_incompatibles(board, Color(9))
    secuence_invalid = MockQueensSecuences.derive_or_nothing(secuence_invalid, Color(9), incompatibles)
    @test secuence_invalid == nothing
end

function test_queens_set_partial_solution_step_by_step()
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)
    #step 0
    queens_set = MockQueensSet.new()
    IQueensSet.init!(queens_set)

    queens_set0 = queens_set
    secuence = queens_set0.exp_secuences_list[1]
    @test secuence.positions == [0]
    @test secuence.colors_used == Set([0])
    #step 1  0 -> 3 & 0 -> 4
    queens_set03 = deepcopy(queens_set0)
    incompatibles = Chessboard.get_color_incompatibles(board, Color(3))
    IQueensSet.up!(queens_set03, Color(3),incompatibles)

    secuence = queens_set03.exp_secuences_list[1]
    @test secuence.positions == [0,3]
    @test secuence.colors_used == Set([0,3])

    queens_set04 = deepcopy(queens_set0)
    incompatibles = Chessboard.get_color_incompatibles(board, Color(4))
    IQueensSet.up!(queens_set04, Color(4),incompatibles)

    secuence = queens_set04.exp_secuences_list[1]
    @test secuence.positions == [0,4]
    @test secuence.colors_used == Set([0,4])
    #step 2 [3 -> 5 & 4 -> 5]
    #Join
    incompatibles = Chessboard.get_color_incompatibles(board, Color(5))
    queens_set035 = deepcopy(queens_set03)
    IQueensSet.up!(queens_set035, Color(5),incompatibles)
    queens_set045 = deepcopy(queens_set04)
    IQueensSet.up!(queens_set045, Color(5),incompatibles)

    IQueensSet.join!(queens_set035, queens_set045)
    queens_set0_34_5 = deepcopy(queens_set035)

    secuence = queens_set0_34_5.exp_secuences_list[1]
    @test secuence.positions == [0,3,5]
    @test secuence.colors_used == Set([0,3,5])
    secuence = queens_set0_34_5.exp_secuences_list[2]
    @test secuence.positions == [0,4,5]
    @test secuence.colors_used == Set([0,4,5])

    #step 3 [5 -> 12]
    incompatibles = Chessboard.get_color_incompatibles(board, Color(12))
    queens_set0_34_512 = deepcopy(queens_set0_34_5)
    IQueensSet.up!(queens_set0_34_512, Color(12),incompatibles)

    @test length(queens_set0_34_512.exp_secuences_list) == 1
    secuence = queens_set0_34_512.exp_secuences_list[1]
    @test secuence.positions == [0,3,5,12]
    @test secuence.colors_used == Set([0,3,5,12])

    #step 4 [12 -> 14]
    incompatibles = Chessboard.get_color_incompatibles(board, Color(14))
    queens_set03512_14 = deepcopy(queens_set0_34_512)
    IQueensSet.up!(queens_set03512_14, Color(14),incompatibles)

    @test length(queens_set03512_14.exp_secuences_list) == 1
    secuence = queens_set03512_14.exp_secuences_list[1]
    @test secuence.positions == [0,3,5,12,14]
    @test secuence.colors_used == Set([0,3,5,12,14])

    #step 5 [14 -> 17]
    incompatibles = Set{Color}([])
    queens_set0351214_17 = deepcopy(queens_set03512_14)
    IQueensSet.up!(queens_set0351214_17, Color(17),incompatibles)

    @test length(queens_set0351214_17.exp_secuences_list) == 1
    secuence = queens_set0351214_17.exp_secuences_list[1]
    @test secuence.positions == [0,3,5,12,14,17]
    @test secuence.colors_used == Set([0,3,5,12,14,17])


end

test_simulate_derivion_of_secuence()
test_queens_set_partial_solution_step_by_step()
