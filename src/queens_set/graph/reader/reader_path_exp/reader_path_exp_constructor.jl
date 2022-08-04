function new(queens_set :: GQueensSet, limit :: UInt128)
    step = Step(0)
    paths_solvers = Array{PathSolutionReader,1}()
    paths_solution = Array{PathSolutionReader,1}()

    exp_solver = PathSolutionExpReader(step, limit, paths_solvers, paths_solution)
    init_generar_paths_semillas!(exp_solver, queens_set)

    return exp_solver
end

function init_generar_paths_semillas!(exp_solver :: PathSolutionExpReader, queens_set :: GQueensSet)
    if exp_solver.limit > 0
        solver_semilla = PathReader.new(queens_set)
        push!(exp_solver.paths_solvers, solver_semilla)
        exp_solver.limit-= 1
    end
end
