module Checker
    using Main.NQueens.Alias: Step, Color
    using Main.NQueens.Alias

    using Main.NQueens.Chessboard: ChessboardMap
    using Main.NQueens.Chessboard


    function are_all_valid(list_certificates :: Array{Array{Color,1},1}, board :: ChessboardMap) :: Bool
        for certificate in list_certificates
            if !is_valid(certificate, board)
                return false
            end
        end
        return true
    end

    function is_valid(certificate :: Array{Color,1}, board :: ChessboardMap) :: Bool
        for position_color in certificate
            compatibles = Chessboard.get_color_compatibles(board, position_color)
            for position_checking in certificate
                is_compatible = position_checking in compatibles
                if !is_compatible
                    return false
                end
            end
        end

        return true
    end

end
