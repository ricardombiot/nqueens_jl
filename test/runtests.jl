using Test
include("./../src/main.jl")


@time @testset "nQueens" begin
    include("test_chessboard_map.jl")
    include("test_timeline.jl")

    include("./queens_set_mock/test_mock_queens_set.jl")

    include("test_execution.jl")
end
