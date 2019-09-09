export add_find_max, add_find_min, add_find_ith

function add_find_max(mgr::Ptr{Manager}, f::Ptr{Node})
    result = ccall((:Cudd_addFindMax, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}), mgr, f)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end

function add_find_min(mgr::Ptr{Manager}, f::Ptr{Node})
    result = ccall((:Cudd_addFindMin, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}), mgr, f)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end

function add_find_ith(mgr::Ptr{Manager}, f::Ptr{Node}, i::Int)
    result = ccall((:Cudd_addIthBit, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Cuint), mgr, f, i)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end
