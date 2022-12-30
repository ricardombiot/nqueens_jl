function test_machine_running_n4()
    n = Color(7)
    instance = NQueensInstance.new(n)

    machine = NQueensMachine.new(instance)
    NQueensMachine.init_db!(machine)

    NQueensMachine.run!(machine)

    queens_set = NQueensMachine.get_queens_set_solution(machine)
    @test queens_set.is_valid

    #certificates = IQueensSet.read(queens_set, n^n)
    #println(certificates)

    certificates = NQueensMachine.get_all_certificates_checked(machine)
    println(certificates)
end

function test_counting_configurations()
    expected_solutions = Dict(4=>2,5=>10,6=>4,7=>40,8=>92,
                              9=>352,10=>724)

    for n in 4:10
        instance = NQueensInstance.new(n)
        machine = NQueensMachine.new(instance)
        NQueensMachine.init_db!(machine)
        NQueensMachine.run!(machine)

        queens_set = NQueensMachine.get_queens_set_solution(machine)
        @test queens_set.is_valid

        certificate = NQueensMachine.get_one_certificate_checked(machine)
        println(certificate)

        certificates = NQueensMachine.get_all_certificates_checked(machine)
        println(certificates)

        total_solutions = length(certificates)
        @test total_solutions == expected_solutions[n]
        println("Found & Checked $total_solutions solutions on N[$n] - Test: OK")
    end
end

function test_instances_without_solution_n4()
    n = Color(4)
    list_instances = Array{Instance,1}()
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(1))
    push!(list_instances, instance)
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(6))
    push!(list_instances, instance)
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(7))
    push!(list_instances, instance)
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(10))
    push!(list_instances, instance)
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(11))
    push!(list_instances, instance)
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(13))
    push!(list_instances, instance)
    instance = NQueensInstance.new(n)
    NQueensInstance.include_queen_by_color!(instance, Color(16))
    push!(list_instances, instance)

    for instance in list_instances
        machine = NQueensMachine.new(instance)
        NQueensMachine.init_db!(machine)

        NQueensMachine.run!(machine)
        @test !NQueensMachine.have_solution(machine)
    end
end

#test_machine_running_n4()
test_counting_configurations()
#test_instances_without_solution_n4()
