module DBExecuteAction
    using Main.NQueens.Alias: Color, ActionId

    using Main.NQueens.IQueensSet
    using Main.NQueens.Chessboard: ChessboardMap
    using Main.NQueens.Chessboard
    using Main.NQueens.TimelineCell: TimelineCellData
    using Main.NQueens.TimelineCell
    using Main.NQueens.DBActions: DatabaseActions
    using Main.NQueens.DBActions

    using Main.NQueens.Actions: Action
    using Main.NQueens.Actions

    function execute_cell!(db :: DatabaseActions, cell :: TimelineCellData, board :: ChessboardMap)
        DBActions.create_action!(db, cell.action_id, cell.parents)
        incompatibles = Chessboard.get_color_incompatibles(board, cell.color)

        apply!(db, cell.action_id, incompatibles)
        cell.was_success_executed = checkif_was_sucess_execution(db, cell.action_id)
    end

    function apply!(db :: DatabaseActions, action_id :: ActionId, incompatibles :: Set{Color})
        action = DBActions.get_action(db, action_id)

        for parent_id in action.parents
            copy_queens_set = DBActions.create_copy_action_queens_set(db, parent_id)

            IQueensSet.up!(copy_queens_set, action.color, incompatibles)
            Actions.ifnotempty_push_queens_set!(action, copy_queens_set)
        end
    end

    function checkif_was_sucess_execution(db :: DatabaseActions, action_id :: ActionId) :: Bool
        action = DBActions.get_action(db, action_id)
        return Actions.was_success_execution(action)
    end

end
