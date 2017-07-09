export add_negate, add_round_off

function add_negate(mgr::Ptr{Manager}, f::Ptr{Node})
    result = ccall((:Cudd_addNegate, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}), mgr, f)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end

function add_round_off(mgr::Ptr{Manager}, f::Ptr{Node}, n::Int)
    result = ccall((:Cudd_addRoundOff, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Cuint), mgr, f, n)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end
