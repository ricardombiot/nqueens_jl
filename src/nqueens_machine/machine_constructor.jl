
   function new(instance :: Instance) :: Machine
      n = instance.n
      step_init = Step(1)

      board = Chessboard.new(n)
      Chessboard.build!(board)
      timeline = Timeline.new(n)

      db_actions = nothing
      queens_set_solution = nothing
      is_finished = false

      machine = Machine(n, instance, step_init, board, timeline, db_actions, queens_set_solution, is_finished)
      init_timeline!(machine)

      return machine
   end

   function init_timeline!(machine :: Machine)
      Timeline.init!(machine.timeline)
      NQueensInstance.apply_restrictions_timeline!(machine.instance, machine.timeline, machine.board)

      color = Color(0)
      action_id = ActionId(color)
      Timeline.success_cell_execution!(machine.timeline, color)
      TimelinePropagation.apply!(machine.timeline, machine.board, color)
   end

   function init_db!(machine :: Machine)
      db = DBActions.new()
      seed_queens_set = GraphQueensSet.new(machine.n)
      DBActions.init!(db, seed_queens_set)
      machine.db_actions = db
   end

   function init_db_mock!(machine :: Machine)
      db = DBActions.new()
      seed_queens_set = MockQueensSet.new(n)
      DBActions.init!(db, seed_queens_set)
      machine.db_actions = db
   end
