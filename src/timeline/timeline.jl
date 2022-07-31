module Timeline

    using Main.NQueens.Alias: Step, Color, ActionId
    using Main.NQueens.Alias

    using Main.NQueens.TimelineCell: TimelineCellData
    using Main.NQueens.TimelineCell

    mutable struct TimelineTable
        n :: Color
        table :: Dict{Step, Dict{Color, TimelineCellData}}
        pivot_colors :: Set{Color}
    end

    function new(n :: Color)
        table = Dict{Step, Dict{Color, TimelineCellData}}()
        pivot_colors = Set{Color}()

        return TimelineTable(n, table, pivot_colors)
    end

    function init!(timeline :: TimelineTable)
        n = timeline.n

        color = Color(0)
        step = Step(0)
        # Start Cell
        init_cell!(timeline, step, color)
        push!(timeline.pivot_colors, color)
        # Board Cells
        for row in 1:n
            step += 1
            for col in 1:n
                color += 1
                init_cell!(timeline, step, color)
            end
        end

        # End Cell
        step += 1
        color += 1
        init_cell!(timeline, step, color)
        push!(timeline.pivot_colors, color)
    end

    function init_cell!(timeline :: TimelineTable, step :: Step, color :: Color)
        if !haskey(timeline.table, step)
            timeline.table[step] = Dict{Color, TimelineCellData}()
        end

        timeline.table[step][color] = TimelineCell.new(color)
    end

    function get_cell(timeline :: TimelineTable, step :: Step, color :: Color) :: Union{TimelineCellData, Nothing}
        if !haskey(timeline.table, step)
            return nothing
        end

        if !haskey(timeline.table[step], color)
            return nothing
        end

        return timeline.table[step][color]
    end


end
