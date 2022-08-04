function calc!(exp_solver :: PathSolutionExpReader)
    #! [recursive-if] $ O(N) $
    if make_step!(exp_solver)
        # Potencially... $ O(EXP) $
        calc!(exp_solver)
    end
end

function make_step!(exp_solver :: PathSolutionExpReader) :: Bool
    next_solvers = Array{PathSolutionReader,1}()
    recursive_pop!(exp_solver, next_solvers)

    is_finished = isempty(exp_solver.paths_solvers)

    exp_solver.step += 1
    return !is_finished
end

function recursive_pop!(exp_solver :: PathSolutionExpReader, next_solvers :: Array{PathSolutionReader,1})
    #! [recursive-if] $ O(L) $
    if !isempty(exp_solver.paths_solvers)
        path = pop!(exp_solver.paths_solvers)
        if path.next_node_id != nothing
            derive_path_next_step!(exp_solver, path, next_solvers)
        else
            push!(exp_solver.paths_solution, path)
        end

        recursive_pop!(exp_solver, next_solvers)
    else
        exp_solver.paths_solvers = next_solvers
    end
end


function derive_path_next_step!(exp_solver :: PathSolutionExpReader, path :: PathSolutionReader, next_solvers :: Array{PathSolutionReader,1})
    PathReader.push_step!(path)
    # Expensive...
    #copy_path = deepcopy(path)

    if path.queens_set.is_valid
        if exp_solver.limit > 0
            derive_fixed_next!(exp_solver, path, next_solvers)
        else
            PathReader.fixed_next!(path)
            PathReader.reduce_graph!(path)
            push!(next_solvers, path)
        end
    else
        throw("mmm... Not valid graph...")
        #println("Not valid graph")
        #graph_plot(exp_solver, copy_path)
    end
end


function derive_fixed_next!(exp_solver :: PathSolutionExpReader, path :: PathSolutionReader, next_solvers :: Array{PathSolutionReader,1})

    node = GraphQueensSet.get_node(path.queens_set, path.next_node_id)
    sons = deepcopy(node.sons)
    if !isempty(sons)
        n_sons = length(sons)
        max_count_total_sons = min(Int64(exp_solver.limit), n_sons)

        total_sons = 0
        #! [for] $ O(N) $
        for node_id in sons
            copy_path = deepcopy(path)
            copy_path.next_node_id = node_id
            #println(" --- Derive ---")
            #selected = Alias.as_key(node_id)
            #println("Selected: [$selected]")
            PathReader.reduce_graph!(copy_path)
            if is_valid_selection(copy_path)
                push!(next_solvers, copy_path)
            else
                println("Warning: After clear graph not valid")
            end
            #println(" --- End Derive ---")

            total_sons += 1
            if max_count_total_sons == total_sons-1
                break
            end
        end

        update_limit(exp_solver, total_sons)
    else
        path.next_node_id = nothing
        push!(next_solvers, path)
    end
end


function is_valid_selection(copy_path :: PathSolutionReader ) :: Bool
    node = GraphQueensSet.get_node(copy_path.queens_set, copy_path.next_node_id)

    exist_selection = node != nothing
    return copy_path.queens_set.is_valid && exist_selection
end


function update_limit(exp_solver :: PathSolutionExpReader, total_sons :: Int64)
    if total_sons != 1
        if (total_sons-1) == exp_solver.limit
            exp_solver.limit = UInt128(0)
        else
            exp_solver.limit -= (total_sons-1)
        end
    end
end
