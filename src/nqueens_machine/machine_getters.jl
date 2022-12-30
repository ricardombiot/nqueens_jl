function have_solution(machine :: Machine) :: Bool
    return machine.queens_set_solution != nothing
end

function get_queens_set_solution(machine :: Machine)
    return deepcopy(machine.queens_set_solution)
end

function get_one_certificate_checked(machine :: Machine) :: Union{Array{Color,1}, Nothing}
    queens_set_solution = get_queens_set_solution(machine)

    if queens_set_solution != nothing
        reader = PathReader.new(queens_set_solution)
        PathReader.calc!(reader)
        certicate = PathReader.get_configuration(reader)

        if !Checker.is_valid(certicate, machine.board)
            throw("Certificate is invalid... :(")
        end

        return certicate
    else
        return nothing
    end
end

function get_all_certificates_checked(machine :: Machine) :: Array{Array{Color,1}}
    queens_set_solution = get_queens_set_solution(machine)
    list_certificates = IQueensSet.read(queens_set_solution, machine.n^machine.n)

    if !Checker.are_all_valid(list_certificates, machine.board)
        throw("At least one certificate is invalid... :(")
    end

    return list_certificates
end
