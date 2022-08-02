module MockQueensSecuences
   using Main.NQueens.Alias: Step, Color
   using Main.NQueens.Alias

   mutable struct MQueensSecuence
      positions :: Array{Color,1}
      colors_used :: Set{Color}
      steps :: Step
   end

   function new() :: MQueensSecuence
      positions = Array{Color,1}()
      colors_used = Set{Color}()
      steps = 0
      MQueensSecuence(positions, colors_used, steps)
   end

   function seed() :: MQueensSecuence
      secuence_seed = new()
      incompatibles = Set{Color}()
      secuence_seed = derive_or_nothing(secuence_seed, Color(0), incompatibles)
      return secuence_seed
   end

   function derive_or_nothing(secuence :: MQueensSecuence, color :: Color, incompatibles :: Set{Color}) :: Union{MQueensSecuence, Nothing}
      set_intersect = intersect(secuence.colors_used, incompatibles)
      if isempty(set_intersect)
         push!(secuence.positions, color)
         push!(secuence.colors_used, color)
         secuence.steps += 1

         return secuence
      else
         return nothing
      end
   end


end
