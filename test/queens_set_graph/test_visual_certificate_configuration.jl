
function test_visual_graph_queens_set_certificate_configuration()
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

    #STEP 1 [0,2]
    incompatibles = Chessboard.get_color_incompatibles(board, Color(2))
    IQueensSet.up!(queens_set, Color(2), incompatibles)

    node_id02 = Alias.new_node_id(ActionId(2),ActionId(0))
    node02 = GraphQueensSet.get_node(queens_set, node_id02)

    @test node02.step == Step(1)
    @test node02.action_id == ActionId(2)
    @test node02.color == Color(2)

    @test node0.owners == Set([node_id0,node_id02])
    @test node0.parents == Set([])
    @test node0.sons == Set([node_id02])

    @test node02.owners == Set([node_id0,node_id02])
    @test node02.parents == Set([node_id0])
    @test node02.sons == Set([])


    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_up02")
    #STEP 2 [0,2,8]

    println("Step 2 [0,2,8]")

    incompatibles = Chessboard.get_color_incompatibles(board, Color(8))
    IQueensSet.up!(queens_set, Color(8), incompatibles)

    node_id028 = Alias.new_node_id(ActionId(8),ActionId(2))
    node028 = GraphQueensSet.get_node(queens_set, node_id028)

    @test node028.step == Step(2)
    @test node028.action_id == ActionId(8)
    @test node028.color == Color(8)

    @test node0.owners == Set([node_id0,node_id02,node_id028])
    @test node0.parents == Set([])
    @test node0.sons == Set([node_id02])

    @test node02.owners == Set([node_id0,node_id02,node_id028])
    @test node02.parents == Set([node_id0])
    @test node02.sons == Set([node_id028])

    @test node028.owners == Set([node_id0,node_id02,node_id028])
    @test node028.parents == Set([node_id02])
    @test node028.sons == Set([])


    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_up028")

    println("Step 3 [0,2,8,9]")

    incompatibles = Chessboard.get_color_incompatibles(board, Color(9))
    IQueensSet.up!(queens_set, Color(9), incompatibles)

    node_id0289 = Alias.new_node_id(ActionId(9),ActionId(8))
    node0289 = GraphQueensSet.get_node(queens_set, node_id0289)

    @test node0289.step == Step(3)
    @test node0289.action_id == ActionId(9)
    @test node0289.color == Color(9)

    @test node0.owners == Set([node_id0,node_id02,node_id028,node_id0289])
    @test node0.parents == Set([])
    @test node0.sons == Set([node_id02])

    @test node02.owners == Set([node_id0,node_id02,node_id028,node_id0289])
    @test node02.parents == Set([node_id0])
    @test node02.sons == Set([node_id028])

    @test node028.owners == Set([node_id0,node_id02,node_id028,node_id0289])
    @test node028.parents == Set([node_id02])
    @test node028.sons == Set([node_id0289])

    @test node0289.owners == Set([node_id0,node_id02,node_id028,node_id0289])
    @test node0289.parents == Set([node_id028])
    @test node0289.sons == Set([])

    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_up0289")


    println("Step 4 [0,2,8,9,15]")

    incompatibles = Chessboard.get_color_incompatibles(board, Color(15))
    IQueensSet.up!(queens_set, Color(15), incompatibles)

    node_id028915 = Alias.new_node_id(ActionId(15),ActionId(9))
    node028915 = GraphQueensSet.get_node(queens_set, node_id028915)

    @test node028915.step == Step(4)
    @test node028915.action_id == ActionId(15)
    @test node028915.color == Color(15)

    @test node0.owners == Set([node_id0,node_id02,node_id028,node_id0289,node_id028915])
    @test node0.parents == Set([])
    @test node0.sons == Set([node_id02])

    @test node02.owners == Set([node_id0,node_id02,node_id028,node_id0289, node_id028915])
    @test node02.parents == Set([node_id0])
    @test node02.sons == Set([node_id028])

    @test node028.owners == Set([node_id0,node_id02,node_id028,node_id0289, node_id028915])
    @test node028.parents == Set([node_id02])
    @test node028.sons == Set([node_id0289])

    @test node0289.owners == Set([node_id0,node_id02,node_id028,node_id0289, node_id028915])
    @test node0289.parents == Set([node_id028])
    @test node0289.sons == Set([node_id028915])

    @test node028915.owners == Set([node_id0,node_id02,node_id028,node_id0289, node_id028915])
    @test node028915.parents == Set([node_id0289])
    @test node028915.sons == Set([])

    diagram = DiagramGraphQueensSet.build(queens_set)
    DiagramGraphQueensSet.to_png(diagram, "test_up028915")

end

test_visual_graph_queens_set_certificate_configuration()
