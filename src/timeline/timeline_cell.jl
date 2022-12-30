module TimelineCell

    using Main.NQueens.Alias: Step, Color, ActionId
    using Main.NQueens.Alias

    mutable struct TimelineCellData
       step :: Step
       color :: Color
       action_id :: ActionId
       parents :: Set{ActionId}
       was_success_executed :: Bool
       is_blocked :: Bool
    end

    function new(step :: Step, color :: Color) :: TimelineCellData
        action_id = ActionId(color)
        parents = Set{ActionId}()
        was_success_executed = false
        is_blocked = false

        return TimelineCellData(step, color, action_id, parents, was_success_executed,is_blocked)
    end

    function push_parent!(cell :: TimelineCellData, parent_id :: ActionId)
        is_accepted_position = !cell.is_blocked
        if is_accepted_position
            push!(cell.parents, parent_id)
        end
    end

end
