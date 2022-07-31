module TimelineCell

    using Main.NQueens.Alias: Color, ActionId
    using Main.NQueens.Alias

    mutable struct TimelineCellData
       color :: Color
       action_id :: ActionId
       parents :: Set{ActionId}
       was_success_executed :: Bool
    end

    function new(color :: Color) :: TimelineCellData
        action_id = ActionId(color)
        parents = Set{ActionId}()
        was_success_executed = false

        return TimelineCellData(color, action_id, parents, was_success_executed)
    end

    function push_parent!(cell :: TimelineCellData, parent_id :: ActionId)
        push!(cell.parent, parent_id)
    end

end
