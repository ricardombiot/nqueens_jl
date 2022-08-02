module DBActions

    using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet
    using Main.NQueens.Alias
    using Main.NQueens.IQueensSet

    using Main.NQueens.Actions: Action
    using Main.NQueens.Actions

    mutable struct DatabaseActions
       table :: Dict{ActionId, Action}
    end

    function new()
        table = Dict{ActionId, Action}()
        DatabaseActions(table)
    end

    function init!(db :: DatabaseActions, queens_set_seed :: AbstractQueensSet)
        color_init = Color(0)
        action_id_init = ActionId(color_init)

        IQueensSet.init!(queens_set_seed) #, color_init, action_id_init)
        action_init = Actions.new_init(action_id_init, queens_set_seed)
        register_action!(db, action_init)
    end

    function create_action!(db :: DatabaseActions, action_id :: ActionId, parents :: Set{ActionId})
        action = Actions.new(action_id, parents)
        register_action!(db, action)
    end

    function register_action!(db :: DatabaseActions, action :: Action)
        db.table[action.action_id] = action
    end

    function get_action(db :: DatabaseActions, action_id :: ActionId) :: Union{Nothing, Action}
        if haskey(db.table,action_id)
            return db.table[action_id]
        end

        return nothing
    end

    function create_copy_action_queens_set(db :: DatabaseActions, action_id :: ActionId) :: Union{AbstractQueensSet, Nothing}
        action = get_action(db, action_id)

        if action != nothing
            return deepcopy(action.queens_set)
        else
            return nothing
        end
    end

end
