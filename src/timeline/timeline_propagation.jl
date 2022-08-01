module TimelinePropagation

    using Main.NQueens.Alias: Color, ActionId
    using Main.NQueens.Alias

    using Main.NQueens.Chessboard: ChessboardMap
    using Main.NQueens.Chessboard
    using Main.NQueens.TimelineCell: TimelineCellData
    using Main.NQueens.TimelineCell
    using Main.NQueens.Timeline: TimelineTable
    using Main.NQueens.Timeline

    function apply!(timeline :: TimelineTable, board :: ChessboardMap, color :: Color)
        cell_origin = Timeline.get_cell(timeline, color)

        if cell_origin.was_success_executed
            set_aceptation_colors = load_aceptation_colors(timeline,board, color)
            send_as_parents!(timeline, set_aceptation_colors, cell_origin)
        end
    end

    function load_aceptation_colors(timeline :: TimelineTable, board :: ChessboardMap, color :: Color) :: Set{Color}
        if color in timeline.pivot_colors
            set_aceptation_colors = deepcopy(board.all_colors)
        else
            set_aceptation_colors = deepcopy(Chessboard.get_color_compatibles(board, color))
        end

        union!(set_aceptation_colors, timeline.pivot_colors)
        return set_aceptation_colors
    end

    function send_as_parents!(timeline :: TimelineTable, set_aceptation_colors :: Set{Color}, cell_origin :: TimelineCellData)
        parent_action_id = cell_origin.action_id
        next_step = cell_origin.step + 1
        for (color_candidate, cell_candidate) in timeline.table[next_step]
            if color_candidate in set_aceptation_colors
                TimelineCell.push_parent!(cell_candidate, parent_action_id)
            end
        end
    end

end
