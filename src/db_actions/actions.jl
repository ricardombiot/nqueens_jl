module Actions

    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet
    using Main.NQueens.Alias

    using Main.NQueens.IQueensSet

    mutable struct Action
       action_id :: ActionId
       color :: Color
       parents :: Set{ActionId}
       queens_set :: Union{AbstractQueensSet, Nothing}
    end


    function new_init(action_id :: ActionId, queens_set :: AbstractQueensSet) :: Action
      color = Color(action_id)
      parents = Set{ActionId}()
      return Action(action_id, color, parents, queens_set)
    end

    function new(action_id :: ActionId, parents :: Set{ActionId}) :: Action
      color = Color(action_id)
      queens_set = nothing
      return Action(action_id, color, parents, queens_set)
    end

    function was_success_execution(action :: Action) :: Bool
      return action.queens_set != nothing
    end

    function push_queens_set!(action :: Action, queens_set :: AbstractQueensSet)
      ifnotempty_push_queens_set!(action, queens_set)
    end

    function ifnotempty_push_queens_set!(action :: Action, queens_set :: AbstractQueensSet)
      is_valid = !IQueensSet.is_empty(queens_set)
      if is_valid
        if action.queens_set == nothing
          action.queens_set = queens_set
        else
          IQueensSet.join!(action.queens_set, queens_set)
        end
      end
    end


end
