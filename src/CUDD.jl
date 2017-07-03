module CUDD
    cd("../deps/cudd-3.0.0/cudd/.libs")

    if isempty(Libdl.find_library(collect(["libcudd.so"])))
        warn("Could not communicate with the CUDD shared lib. Make sure it exists and that it is on the path.")
    else
        # load the shared CUDD library
        global const _LIB_CUDD = Libdl.find_library(collect(["libcudd.so"]))
    end

    include("ADD.jl")

end # end module
