CUDD
====

A Julia wrapper for the [CUDD](http://vlsi.colorado.edu/~fabio/CUDD/cudd.pdf) 
C library to manipulate Algebraic Decision Diagrams (ADDs).


Basic usage:
```julia
>>> using CUDD
>>> manager = initilize_cudd()
>>> x1 = add_var(manager)
>>> ref(x1)
>>> x2 = add_var(manager)
>>> ref(x2)
>>> f = add_apply(manager, add_plus_c, x1, x2)
>>> get_value(evaluate(manager, f, [1, 1]))
2
```

For further examples, see the Julia notebook in the ``docs`` folder.

Setup
-----

Requirements:
 - Julia 0.6
 - A standard build environment (make, gcc, etc.)

To install the CUDD module:

    $ Pkg.add("CUDD")

License
-------

This code is licensed under the MIT license.  See LICENSE for details.

