module NQueensMachine
   using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet
   using Main.NQueens.Alias

   using Main.NQueens.Chessboard: ChessboardMap
   using Main.NQueens.Chessboard

   using Main.NQueens.TimelineCell: TimelineCellData
   using Main.NQueens.TimelineCell
   using Main.NQueens.Timeline: TimelineTable
   using Main.NQueens.Timeline
   using Main.NQueens.TimelinePropagation

   using Main.NQueens.DBActions: DatabaseActions
   using Main.NQueens.DBActions

   using Main.NQueens.DBExecuteAction

   using Main.NQueens.MockQueensSecuences: MQueensSecuence
   using Main.NQueens.MockQueensSecuences

   using Main.NQueens.MockQueensSet: MQueensSet
   using Main.NQueens.MockQueensSet
   using Main.NQueens.GraphQueensSet: GQueensSet
   using Main.NQueens.GraphQueensSet

   using Main.NQueens.PathReader: PathSolutionReader
   using Main.NQueens.PathReader

   using Main.NQueens.PathExpReader: PathSolutionExpReader
   using Main.NQueens.PathExpReader

   using Main.NQueens.NQueensInstance: Instance
   using Main.NQueens.NQueensInstance

   using Main.NQueens.IQueensSet
   using Main.NQueens.Checker

   mutable struct Machine
      n :: Color
      instance :: Instance
      step :: Step
      board :: ChessboardMap
      timeline :: TimelineTable
      db_actions :: Union{DatabaseActions, Nothing}
      queens_set_solution :: Union{AbstractQueensSet, Nothing}
      is_finished :: Bool
   end

   include("./machine_constructor.jl")
   include("./machine_execution.jl")
   include("./machine_getters.jl")


end
