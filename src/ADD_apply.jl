export add_apply
export add_plus, add_minus, add_times, add_divide, add_diff
export add_threshold, add_setNZ
export add_minimum, add_maximum, add_one_zero_maximum
export add_or, add_nand, add_nor, add_xor, add_xnor
export add_log

function add_apply(mgr::Ptr{Manager}, op::Ptr{Void}, f::Ptr{Node}, g::Ptr{Node})
    res = ccall((:Cudd_addApply, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Void}, Ptr{Node}, Ptr{Node}), mgr, op, f, g)
    if res == C_NULL # Fails to compute a result
        throw(OutOfMemoryError())
    end
    return res
end

function add_plus(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addPlus, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_plus_c = cfunction(add_plus, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_minus(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addMinus, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_minus_c = cfunction(add_minus, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_times(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addTimes, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_times_c = cfunction(add_times, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_divide(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addDivide, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_divide_c = cfunction(add_divide, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_diff(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addDiff, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_diff_c = cfunction(add_diff, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_threshold(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addThreshold, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_threshold_c = cfunction(add_threshold, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_setNZ(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addSetNZ, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_setnz_c = cfunction(add_setNZ, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_minimum(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addMinimum, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_minimum_c = cfunction(add_minimum, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_maximum(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addMaximum, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_maximum_c = cfunction(add_maximum, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_one_zero_maximum(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addOneZeroMaximum, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_one_zero_maximum_c = cfunction(add_one_zero_maximum, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_agreement(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addAgreement, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_agreement_c = cfunction(add_agreement, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_or(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addOr, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_or_c = cfunction(add_or, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_nand(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addNand, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_nand_c = cfunction(add_nand, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_nor(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addNor, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_nor_c = cfunction(add_nor, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_xor(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addXor, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_xor_c = cfunction(add_xor, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_xnor(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addXnor, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_xnor_c = cfunction(add_xnor, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))

function add_log(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}})
    func = ccall((:Cudd_addLog, _LIB_CUDD),
        Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)
    return func
end
add_log_c = cfunction(add_log, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))