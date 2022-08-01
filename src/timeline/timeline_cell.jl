module TimelineCell

    using Main.NQueens.Alias: Step, Color, ActionId
    using Main.NQueens.Alias

    mutable struct TimelineCellData
       step :: Step
       color :: Color
       action_id :: ActionId
       parents :: Set{ActionId}
       was_success_executed :: Bool
    end

    function new(step :: Step, color :: Color) :: TimelineCellData
        action_id = ActionId(color)
        parents = Set{ActionId}()
        was_success_executed = false

        return TimelineCellData(step, color, action_id, parents, was_success_executed)
    end

    function push_parent!(cell :: TimelineCellData, parent_id :: ActionId)
        push!(cell.parents, parent_id)
    end

end
