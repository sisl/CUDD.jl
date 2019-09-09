export add_apply
export add_plus_c, add_minus_c, add_times_c, add_divide_c, add_diff_c
export add_threshold_c, add_setnz_c
export add_minimum_c, add_maximum_c, add_one_zero_maximum_c
export add_or_c, add_nand_c, add_nor_c, add_xor_c, add_xnor_c
export add_log_c

function add_apply(mgr::Ptr{Manager}, op::Ref, f::Ptr{Node}, g::Ptr{Node})
    res = ccall((:Cudd_addApply, libcudd),
        Ptr{Node}, (Ptr{Manager}, Ptr{Cvoid}, Ptr{Node}, Ptr{Node}), mgr, op[], f, g)
    if res == C_NULL # Fails to compute a result
        throw(OutOfMemoryError())
    end
    return res
end

add_apply_func_names = [(:add_plus, :Cudd_addPlus),
                        (:add_minus, :Cudd_addMinus),
                        (:add_times, :Cudd_addTimes),
                        (:add_divide, :Cudd_addDivide),
                        (:add_diff, :Cudd_addDiff),
                        (:add_threshold, :Cudd_addThreshold),
                        (:add_setNZ, :Cudd_addSetNZ),
                        (:add_minimum, :Cudd_addMinimum),
                        (:add_maximum, :Cudd_addMaximum),
                        (:add_one_zero_maximum, :Cudd_addOneZeroMaximum),
                        (:add_agreement, :Cudd_addAgreement),
                        (:add_or, :Cudd_addOr),
                        (:add_nand, :Cudd_addNand),
                        (:add_nor, :Cudd_addNor),
                        (:add_xor, :Cudd_addXor),
                        (:add_xnor, :Cudd_addXnor),
                        (:add_log, :Cudd_addLog)]

for (name, Cudd_name) in add_apply_func_names
    @eval $name(mgr::Ptr{Manager}, f_pp::Ptr{Ptr{Node}}, g_pp::Ptr{Ptr{Node}}) =
                ccall(($(QuoteNode(Cudd_name)), libcudd),
                      Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}), mgr, f_pp, g_pp)

    # these Refs should get filled in __init__()
    @eval const $(Symbol(name, "_c")) = Ref{Ptr{Cvoid}}()
end

function __init__()
    for (name, _) in add_apply_func_names
        @eval $(Symbol(name, "_c"))[] = Compat.@cfunction($name, Ptr{Node}, (Ptr{Manager}, Ptr{Ptr{Node}}, Ptr{Ptr{Node}}))
    end
end
