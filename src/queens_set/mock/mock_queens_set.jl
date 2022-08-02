module MockQueensSet
   using Main.NQueens.Alias: Step, Color, ActionId, AbstractQueensSet
   using Main.NQueens.Alias

   using Main.NQueens.MockQueensSecuences: MQueensSecuence
   using Main.NQueens.MockQueensSecuences

   mutable struct MQueensSet <: AbstractQueensSet
      exp_secuences_list :: Array{MQueensSecuence,1}
   end

   function new() :: MQueensSet
      exp_secuences_list = Array{MQueensSecuence,1}()
      return MQueensSet(exp_secuences_list)
   end

   function init!(queens_set :: MQueensSet)
      secuence_seed = MockQueensSecuences.seed()
      push!(queens_set.exp_secuences_list, secuence_seed)
   end

   function up!(queens_set :: MQueensSet, color :: Color, incompatibles :: Set{Color})
      new_exp_secuences_list = Array{MQueensSecuence,1}()

      # O(EXP)
      for secuence in queens_set.exp_secuences_list
         secuence = MockQueensSecuences.derive_or_nothing(secuence, color, incompatibles)
         if secuence != nothing
            push!(new_exp_secuences_list, secuence)
         end
      end

      queens_set.exp_secuences_list = new_exp_secuences_list
   end

   function join!(queens_set_a :: MQueensSet, queens_set_b :: MQueensSet)
      # O(EXP)
      for secuence in queens_set_b.exp_secuences_list
         push!(queens_set_a.exp_secuences_list, deepcopy(secuence))
      end
   end

   function is_valid(queens_set :: MQueensSet) :: Bool
      return !is_empty(queens_set)
   end

   function is_empty(queens_set :: MQueensSet) :: Bool
      return isempty(queens_set.exp_secuences_list)
   end

   function read(queens_set :: MQueensSet, limit :: Int64) :: Array{Array{Color},1}
      list_certificates = Array{Array{Color},1}()
      while !isempty(queens_set.exp_secuences_list)
         secuence = pop!(queens_set.exp_secuences_list)
         push!(list_certificates, secuence.positions)

         if limit == 0
            return list_certificates
         else
            limit -= 1
         end
      end

      return list_certificates
   end

end
