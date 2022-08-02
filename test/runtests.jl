using Test
include("./../src/main.jl")


@time @testset "nQueens" begin

    #=
    @time @testset "General" begin
        include("test_chessboard_map.jl")
        include("test_timeline.jl")
        include("./queens_set_mock/test_mock_queens_set.jl")

        include("test_execution.jl")
    end
    =#




    @time @testset "GQueensGraph" begin
        #include("./queens_set_graph/test_visual_wrong_configuration.jl")
        #include("./queens_set_graph/test_visual_certificate_configuration.jl")
        include("./queens_set_graph/test_execution_gqueens_set.jl")
    end
end
