module Propagation

    using Main.NQueens.Alias: Color, ActionId
    using Main.NQueens.Alias

    using Main.NQueens.TimelineCell: TimelineCellData
    using Main.NQueens.TimelineCell

    using Main.NQueens.Timeline: Timeline
    using Main.NQueens.Timeline

    function apply!(timeline :: TimelineTable, board :: ChessboardMap, color :: Color)
        step = Alias.get_step_by_color(board.n, color)
        cell_origin = Timeline.get_cell(step, color)

        if cell_origin.was_execute
            set_aceptation_colors = load_aceptation_colors(timeline,board, color)
            send_as_parents!(timeline, set_aceptation_colors, cell_origin)
        end
    end

    function load_aceptation_colors(timeline :: TimelineTable, board :: ChessboardMap, color :: Color) :: Set{Color}
        if color in timeline.pivot_colors
            set_aceptation_colors = deepcopy(Chessboard.all_colors)
        else
            set_aceptation_colors = deepcopy(Chessboard.get_color_compatibles(color))
        end

        union!(set_aceptation_colors, timeline.pivot_colors)
        return set_aceptation_colors
    end

    function send_as_parents!(timeline :: TimelineTable, set_aceptation_colors :: Set{Color}, cell_origin :: TimelineCellData)
        action_id = cell_origin.action_id
        next_step = cell_origin.step + 1
        for cell_candidate in timeline.table[next_step]
            if cell_candidate.color in set_aceptation_colors
                TimelineCell.push_parent!(cell_candidate, action_id)
            end
        end
    end

end
