module Chessboard
        using Main.NQueens.Alias: Step, Color
        using Main.NQueens.Alias

        mutable struct ChessboardMap
                n :: Color
                all_colors :: Set{Color}
                table_compatibilities :: Dict{Color,Set{Color}}
                table_incompatibilities :: Dict{Color,Set{Color}}
        end

        function new(n :: Color) :: ChessboardMap
                all_colors = Set{Color}()
                for row in 1:n
                        for col in 1:n
                                color_cell = get_color_cell(n, row, col)
                                push!(all_colors, color_cell)
                        end
                end

                table_compatibilities = Dict{Color,Set{Color}}()
                table_incompatibilities = Dict{Color,Set{Color}}()

                return ChessboardMap(n, all_colors, table_compatibilities, table_incompatibilities)
        end

        function build!(board :: ChessboardMap)
                n = board.n
                for row in 1:n
                        for col in 1:n
                                color_cell = get_color_cell(n, row, col)
                                set_row = calc_incompatibilities_row(n, row, color_cell)
                                set_col = calc_incompatibilities_col(n, col, color_cell)
                                set_diagonals = calc_incompatibilities_diagonals(n, row, col)

                                set_all_incomp = Set{Color}()
                                union!(set_all_incomp, set_row)
                                union!(set_all_incomp, set_col)
                                union!(set_all_incomp, set_diagonals)
                                set_all_comp = deepcopy(board.all_colors)
                                setdiff!(set_all_comp, set_all_incomp)

                                board.table_compatibilities[color_cell] = set_all_comp
                                board.table_incompatibilities[color_cell] = set_all_incomp
                        end
                end
        end

        function calc_incompatibilities_row(n :: Color, row :: Color, color :: Color) :: Set{Color}
                set_incompatibilities = Set{Color}()
                for col in 1:n
                        color_cell = get_color_cell(n, row, col)
                        if color_cell != color
                                push!(set_incompatibilities,color_cell)
                        end
                end

                return set_incompatibilities
        end



        function calc_incompatibilities_col(n :: Color, col :: Color, color :: Color) :: Set{Color}
                set_incompatibilities = Set{Color}()
                for row in 1:n
                        color_cell = get_color_cell(n, row, col)
                        if color_cell != color
                                push!(set_incompatibilities,color_cell)
                        end
                end

                return set_incompatibilities
        end


        function calc_incompatibilities_diagonals(n :: Color, row_cell :: Color, col_cell :: Color) :: Set{Color}
                color = get_color_cell(n, row_cell,col_cell)
                dig_pos_cell = row_cell + col_cell
                dig_neg_cell = row_cell - col_cell
                set_incompatibilities = Set{Color}()
                for row in 1:n
                        for col in 1:n
                                color_cell = get_color_cell(n, row, col)
                                if color_cell != color
                                        dig_pos = row + col
                                        dig_neg = row - col

                                        if dig_pos_cell == dig_pos
                                                push!(set_incompatibilities,color_cell)
                                        elseif dig_neg_cell == dig_neg
                                                push!(set_incompatibilities,color_cell)
                                        end
                                end
                        end
                end

                return set_incompatibilities
        end

        function get_color_cell(n :: Color, row_cell :: Color, col_cell :: Color) :: Color
                return (row_cell-1)*n + col_cell
        end

end
