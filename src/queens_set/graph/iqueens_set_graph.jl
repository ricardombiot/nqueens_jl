
  using Main.NQueens.GraphQueensSet: GQueensSet
  using Main.NQueens.GraphQueensSet

  using Main.NQueens.PathReader: PathSolutionReader
  using Main.NQueens.PathReader

  using Main.NQueens.PathExpReader: PathSolutionExpReader
  using Main.NQueens.PathExpReader


  # init!(queens_set_a)

  function init!(queens_set :: GQueensSet)
    GraphQueensSet.init!(queens_set)
  end

  # up!(queens_set_a, color, incompatibles)

  function up!(queens_set :: GQueensSet, color :: Color, incompatibles :: Set{Color})
    GraphQueensSet.up!(queens_set, color, incompatibles)
  end

  # join!(queens_set_a , queens_set_b)
  function join!(queens_set_a :: GQueensSet, queens_set_b :: GQueensSet)
    GraphQueensSet.join!(queens_set_a, queens_set_b)
  end

  # function is_valid(queens_set_a) :: Bool
  function is_valid(queens_set :: GQueensSet) :: Bool
    return GraphQueensSet.is_valid(queens_set)
  end

  # function is_empty(queens_set_a) :: Bool
  function is_empty(queens_set :: GQueensSet) :: Bool
    return GraphQueensSet.is_empty(queens_set)
  end

  function read(queens_set :: GQueensSet, limit :: Int64) :: Array{Array{Color,1},1}
      certificates = Array{Array{Color,1},1}()
      if is_valid(queens_set)
        if limit == 1
          reader = PathReader.new(queens_set)
          PathReader.calc!(reader)
          route = PathReader.get_configuration(reader)
          push!(certificates, route)
        else
          reader_exp = PathExpReader.new(queens_set, UInt128(limit))
          PathExpReader.calc!(reader_exp)
          for reader in reader_exp.paths_solution
            route = PathReader.get_configuration(reader)
            push!(certificates, route)
          end
        end
      end

      return certificates
  end
