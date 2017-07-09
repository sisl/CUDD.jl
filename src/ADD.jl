export Manager, Node
export CUDD_UNIQUE_SLOTS, CUDD_CACHE_SLOTS
export initilize_cudd
export add_var, add_ith_var, add_level_var, add_const, add_constraint
export cudd_ref

mutable struct Manager
end

mutable struct Node
end

const CUDD_UNIQUE_SLOTS = 256
const CUDD_CACHE_SLOTS  = 262144

function initilize_cudd()
    dd_manager = ccall((:Cudd_Init, _LIB_CUDD),
        Ptr{Manager}, (Cuint, Cuint, Cuint, Cuint, Csize_t), 0,0,CUDD_UNIQUE_SLOTS,CUDD_CACHE_SLOTS,0) # default in CUDD
    if dd_manager == C_NULL # Could not allocate memory
        throw(OutOfMemoryError())
    end
    return dd_manager
end

function add_var(mgr::Ptr{Manager})
    new_var = ccall((:Cudd_addNewVar, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager},), mgr)
    if new_var == C_NULL # Could not allocate memory
        throw(OutOfMemoryError())
    end
    return new_var
end

function add_ith_var(mgr::Ptr{Manager}, i::Int)
    new_var = ccall((:Cudd_addIthVar, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Cuint), mgr, i)
    if new_var == C_NULL # Could not allocate memory
        throw(OutOfMemoryError())
    end
    return new_var
end

function add_level_var(mgr::Ptr{Manager}, level::Int)
    new_var = ccall((:Cudd_addNewVarAtLevel, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Cuint), mgr, level)
    if new_var == C_NULL
        throw(OutOfMemoryError())
    end
    return new_var
end

function add_const(mgr::Ptr{Manager}, c::Real)
    const_node = ccall((:Cudd_addConst, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Cdouble), mgr, c)
    if const_node == C_NULL
        throw(OutOfMemoryError())
    end
    return const_node
end

function add_constraint(mgr::Ptr{Manager}, f::Ptr{Node}, c::Ptr{Node})
    constraint = ccall((:Cudd_addConstrain, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, g)
    if constraint == C_NULL
        throw(OutOfMemoryError())
    end
    return constraint
end

function cudd_ref(n::Ptr{Node})
    res = ccall((:Cudd_Ref, _LIB_CUDD), Void, (Ptr{Node},), n)
end
