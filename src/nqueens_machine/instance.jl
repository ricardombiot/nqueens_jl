module NQueensInstance
   using Main.NQueens.Alias: Step, Color
   using Main.NQueens.Alias

   using Main.NQueens.Chessboard: ChessboardMap
   using Main.NQueens.Chessboard

   using Main.NQueens.Timeline: TimelineTable
   using Main.NQueens.Timeline


   mutable struct Instance
      n :: Color
      queens_default :: Set{Color}
   end

   function new(n :: Color)
      queens_default = Set{Color}()
      Instance(n, queens_default)
   end

   function include_queen!(instance :: Instance, row :: Color, col :: Color)
      color = Alias.get_color_cell(instance.n, row, col)
      include_queen_by_color!(instance, color)
   end

   function include_queen_by_color!(instance :: Instance, color :: Color)
      push!(instance.queens_default, color)
   end

   function get_all_blocked_positions(instance :: Instance, board :: ChessboardMap) :: Set{Color}
      incompatible = Set{Color}()
      for color_fixed_queen in instance.queens_default
         incompatibles_fixed_queen = Chessboard.get_color_incompatibles(board, color_fixed_queen)
         union!(incompatible, incompatibles_fixed_queen)
      end

      return incompatible
   end

   function apply_restrictions_timeline!(instance :: Instance, timeline :: TimelineTable, board :: ChessboardMap)
      incompatible = get_all_blocked_positions(instance, board)

      for color_invalid in incompatible
         Timeline.blocked_cell!(timeline, color_invalid)
      end
   end

end
