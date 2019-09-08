export add_scalar_inverse

function add_scalar_inverse(mgr::Ptr{Manager}, f::Ptr{Node}, epsilon::Ptr{Node})
    result = ccall((:Cudd_addScalarInverse, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, epsilon)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end
