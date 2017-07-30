export Manager, Node
export CUDD_UNIQUE_SLOTS, CUDD_CACHE_SLOTS
export initilize_cudd
export add_var, add_ith_var, add_level_var, add_const, add_constraint
export cudd_ref

mutable struct Manager
end

mutable struct Node
end

mutable struct FILE
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
    res = ccall((:Cudd_addConstrain, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, c)
    if res == C_NULL
        throw(OutOfMemoryError())
    end
    return res
end

function add_restrict(mgr::Ptr{Manager}, f::Ptr{Node}, c::Ptr{Node})
    res = ccall((:Cudd_addRestrict, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Node}), mgr, f, c)
    if res == C_NULL
        throw(OutOfMemoryError())
    end
    return res
end

function evaluate(mgr::Ptr{Manager}, f::Ptr{Node}, assignment::Array{Int})
    res = ccall((:Cudd_Eval, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Node}, Ptr{Cint}), mgr, f, assignment)
    if res == C_NULL
        throw(OutOfMemoryError())
    end
    return res
end

function ref(n::Ptr{Node})
    ccall((:Cudd_Ref, _LIB_CUDD), Void, (Ptr{Node},), n)
end

function deref(n::Ptr{Node})
    ccall((:Cudd_Deref, _LIB_CUDD), Void, (Ptr{Node},), n)
end

function recursive_deref(table::Ptr{Manager}, n::Ptr{Node})
    ccall((:Cudd_RecursiveDeref, _LIB_CUDD), Void, (Ptr{Manager}, Ptr{Node}), table, n)
end

function get_value(c::Ptr{Node})
    res = ccall((:Cudd_V, _LIB_CUDD), Cdouble, (Ptr{Node},), c)
    if res == C_NULL
        throw(OutOfMemoryError())
    end
    return res
end

function is_const(n::Ptr{Node})
    return ccall((:Cudd_IsConstant, _LIB_CUDD), Cint, (Ptr{Node},), n)
end

function is_nonconst(n::Ptr{Node})
    return ccall((:Cudd_IsNonConstant, _LIB_CUDD), Cint, (Ptr{Node},), n)
end

function read_index(n::Ptr{Node})
    return ccall((:Cudd_NodeReadIndex, _LIB_CUDD), Cuint, (Ptr{Node},), n)
end

function node_count(mgr::Ptr{Manager})
    return ccall((:Cudd_ReadNodeCount, _LIB_CUDD), Clong, (Ptr{Manager},), mgr)
end

function output_dot(mgr::Ptr{Manager}, f::Ptr{Node}, filename::String)
    outfile = ccall(:fopen, Ptr{FILE}, (Cstring, Cstring), filename, "w")
    res = ccall((:Cudd_DumpDot, _LIB_CUDD), Cint, (Ptr{Manager}, Cint, Ref{Ptr{Node}},
        Ptr{Ptr{UInt8}}, Ptr{Ptr{UInt8}}, Ptr{FILE}), mgr, 1, f, C_NULL, C_NULL, outfile)
    ccall(:fclose, Cint, (Ptr{FILE},), outfile)  # here returns 0 suggesting the file is successfully closed
    return res
end

function output_stats(mgr::Ptr{Manager}, filename::String)
    outfile = ccall(:fopen, Ptr{FILE}, (Cstring, Cstring), filename, "w")
    res = ccall((:Cudd_PrintInfo, _LIB_CUDD), Cint, (Ptr{Manager}, Ptr{FILE}), mgr, outfile)
    ccall(:fclose, Cint, (Ptr{FILE},), outfile)
    return res
end
