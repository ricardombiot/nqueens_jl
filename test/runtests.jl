using Test
include("./../src/main.jl")


@time @testset "nQueens" begin
    include("test_chessboard_map.jl")
end