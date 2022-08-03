function test_init_visual_graph_queens_set()
    n = Color(4)
    #step 0
    queens_set = GraphQueensSet.new(n)
    IQueensSet.init!(queens_set)

    #println(queens_set)
    @test queens_set.step == Step(1)
    #@test haskey(queens_set.table_lines, Step(0))

    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_init_visual")
end

function test_visual_graph_queens_set_wrong_configuration()
    n = Color(4)
    board = Chessboard.new(n)
    Chessboard.build!(board)
    #STEP 0
    queens_set = GraphQueensSet.new(n)
    IQueensSet.init!(queens_set)

    node_id0 = Alias.new_node_id(ActionId(0),nothing)
    node0 = GraphQueensSet.get_node(queens_set, node_id0)

    @test node0.step == Step(0)
    @test node0.action_id == ActionId(0)
    @test node0.color == Color(0)

    @test node0.owners == Set([node_id0])

    #STEP 1 [0,1]
    incompatibles = Chessboard.get_color_incompatibles(board, Color(1))
    IQueensSet.up!(queens_set, Color(1), incompatibles)

    node_id01 = Alias.new_node_id(ActionId(1),ActionId(0))
    node01 = GraphQueensSet.get_node(queens_set, node_id01)

    @test node01.step == Step(1)
    @test node01.action_id == ActionId(1)
    @test node01.color == Color(1)


    @test node0.owners == Set([node_id0,node_id01])
    @test node0.parents == Set([])
    @test node0.sons == Set([node_id01])

    @test node01.owners == Set([node_id0,node_id01])
    @test node01.parents == Set([node_id0])
    @test node01.sons == Set([])


    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_up01")
    #STEP 2 [0,1,7]

    println("Step 2 [0,1,7]")

    incompatibles = Chessboard.get_color_incompatibles(board, Color(7))
    IQueensSet.up!(queens_set, Color(7), incompatibles)

    node_id017 = Alias.new_node_id(ActionId(7),ActionId(1))
    node017 = GraphQueensSet.get_node(queens_set, node_id017)

    @test node0.owners == Set([node_id0,node_id01,node_id017])
    @test node0.parents == Set([])
    @test node0.sons == Set([node_id01])

    @test node01.owners == Set([node_id0,node_id01,node_id017])
    @test node01.parents == Set([node_id0])
    @test node01.sons == Set([node_id017])

    @test node017.owners == Set([node_id0,node_id01,node_id017])
    @test node017.parents == Set([node_id01])
    @test node017.sons == Set([])


    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_up017")

    println("Step 3 [0,1,7,9] Expected break chain because nine(9) isnt compatible with one(1)")

    incompatibles = Chessboard.get_color_incompatibles(board, Color(9))
    IQueensSet.up!(queens_set, Color(9), incompatibles)

    @test queens_set.is_valid == false
end

test_init_visual_graph_queens_set()
test_visual_graph_queens_set_wrong_configuration()
