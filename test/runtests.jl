using CUDD
using Base.Test

@testset "addind vars" begin
    for i = 1:5
        manager = initilize_cudd()
        rnd = rand(1:100)
        for i = 1:rnd
            add_var(manager)
        end
        @test CUDD.node_count(manager)-2 == rnd # the constant 0 and 1 nodes are created automatically
    end

    for i = 1:5
        manager = initilize_cudd()
        rnd = rand(i*10:i*10+9)
        indexed_var = add_ith_var(manager, rnd)
        @test CUDD.read_index(indexed_var) == rnd
    end
end
