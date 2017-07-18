module CUDD
    cudd_path = joinpath(dirname(@__FILE__), "..", "deps", "cudd-3.0.0", "cudd", ".libs")

    if isempty(Libdl.find_library(collect(["libcudd.so"]), collect([cudd_path])))
        warn("Could not communicate with libcudd. Make sure it exists and that it is on the path.")
    else
        # load the shared CUDD library
        global const _LIB_CUDD = Libdl.find_library(collect(["libcudd.so"]), collect([cudd_path]))

        include("ADD.jl")
        include("ADD_apply.jl")
        include("ADD_find.jl")
        include("ADD_abs.jl")
        include("ADD_inverse.jl")
        include("ADD_ITE.jl")
        include("ADD_negate.jl")
        include("ADD_walsh.jl")
    end
end
