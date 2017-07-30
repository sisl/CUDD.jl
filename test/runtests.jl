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

@testset "outputting files" begin
    manager = initilize_cudd()
    g = add_var(manager)
    @test output_dot(manager, g, "test.dot") == 1
    rm("test.dot")
    @test output_stats(manager, "stats") == 1
    rm("stats")
end

@testset "addition testing" begin
    manager = initilize_cudd()
    f = add_ith_var(manager, 1)
    ref(f)
    for i = 2:10
        x = add_ith_var(manager, i)
        ref(x)
        tmp = add_apply(manager, add_plus_c, f, x)
        ref(tmp)
        recursive_deref(manager, x)
        recursive_deref(manager, f)
        f = tmp
    end
    assignment = Int[]
    res = 0
    for i = 1:10
        generated = rand(0:1)
        push!(assignment, generated)
        res += generated
    end
    push!(assignment, 0)
    cudd_res = evaluate(manager, f, assignment)
    value = convert(Int, get_value(cudd_res))
    @test value == res
end

@testset "multiplication testing" begin
    manager = initilize_cudd()
    f = add_ith_var(manager, 1)
    ref(f)
    for i = 2:10
        x = add_ith_var(manager, i)
        ref(x)
        tmp = add_apply(manager, add_times_c, f, x)
        ref(tmp)
        recursive_deref(manager, x)
        recursive_deref(manager, f)
        f = tmp
    end
    assignment = Int[]
    res = 0
    for i = 1:10
        generated = rand(0:1)
        push!(assignment, generated)
        res *= generated
    end
    cudd_res = evaluate(manager, f, assignment)
    value = convert(Int, get_value(cudd_res))
    @test value == res
end