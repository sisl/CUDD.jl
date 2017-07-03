if is_unix()
    download("ftp://vlsi.colorado.edu/pub/cudd-3.0.0.tar.gz", "cudd-3.0.0.tar.gz")
    run(`tar -zxvf cudd-3.0.0.tar.gz`)
    rm("cudd-3.0.0.tar.gz")
    cd("cudd-3.0.0/")

    run(`./configure --enable-silent-rules --enable-shared --enable-obj`)
    run(`make -j4 check`)

    # rename the shared library if it's ended with dylib...
    cd("cudd/.libs")
    if isfile("libcudd.dylib")
        run(`mv libcudd.dylib libcudd.so`)
    end
end