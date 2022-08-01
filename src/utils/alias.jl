module Alias

    const Step = Int64
    const Color = Int64
    const ActionId = Int64

    abstract type AbstractQueensSet end
    
    function get_color_cell(n :: Color, row_cell :: Color, col_cell :: Color) :: Color
            return (row_cell-1)*n + col_cell
    end

    function get_step_by_color(n :: Color, color :: Color) :: Step
        col_cell = Step(rem(color,n))
        if col_cell == 0
            col_cell = n
        end

        return Step((color-col_cell)/n )+ 1
    end

end
