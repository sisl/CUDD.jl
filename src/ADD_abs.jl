export add_exist_abstract, add_univ_abstract, add_or_abstract

function add_exist_abstract(mgr::Ptr{Manager}, f::Ptr{Node}, cube::Ptr{Node})
    result = ccall((:Cudd_addExistAbstract, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, cube)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end

function add_univ_abstract(mgr::Ptr{Manager}, f::Ptr{Node}, cube::Ptr{Node})
    result = ccall((:Cudd_addUnivAbstract, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, cube)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end

function add_or_abstract(mgr::Ptr{Manager}, f::Ptr{Node}, cube::Ptr{Node})
    result = ccall((:Cudd_addOrAbstract, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, cube)
    if result == C_NULL
        throw(OutOfMemoryError())
    end
    return result
end
