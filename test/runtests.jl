using CUDD
using Base.Test

@testset "addind vars" begin
    for i = 1:10
        manager = initilize_cudd()
        rnd = rand(1:100)
        for i = 1:rnd
            add_var(manager)
        end
        @test node_count(manager)-2 == rnd # the constant 0 and 1 nodes are created automatically
    end

    for i = 1:10
        manager = initilize_cudd()
        rnd = rand(i*10:i*10+9)
        indexed_var = add_ith_var(manager, rnd)
        @test read_index(indexed_var) == rnd
    end

    manager = initilize_cudd()
    for i = 1:10
        new_nonconst = add_var(manager)
        @test is_nonconst(new_nonconst) == 1
        new_nonconst = add_level_var(manager, i)
        @test is_nonconst(new_nonconst) == 1
        new_nonconst = add_ith_var(manager, i)
        @test is_nonconst(new_nonconst) == 1
        new_const = add_const(manager, i)
        @test is_const(new_const) == 1
    end
end

@testset "output files" begin
    manager = initilize_cudd()
    g = add_var(manager)
    @test output_dot(manager, g, "test.dot") == 1
    rm("test.dot")
    @test output_stats(manager, "stats") == 1
    rm("stats")
end
