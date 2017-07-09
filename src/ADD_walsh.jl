export add_walsh, add_residue

function add_walsh(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}}, n::Int)
    result = ccall((:Cudd_addWalsh, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}, Cuint), mgr, f_pp, g_pp, n)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end

function add_residue(mgr::Ptr{Manager}, n::Int, m::Int, options::Int, top::Int)
    result = ccall((:Cudd_addResidue, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Cuint, Cuint, Cuint, Cuint), mgr, n, m, options, top)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end