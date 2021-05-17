include("./sparse.jl")
include("./strassens.jl")
include("./naive.jl")
using MatrixMarket
using CSV
using DataFrames


function writeTimes(n, file, func, functionName)
    dir = "../matrices/"
    filename = dir * file
    matrix = MatrixMarket.mmread(filename)
    s = size(matrix)[1]
    for _ in 0:n
        t = @timed func(matrix, matrix)
        millis = t[2] * 1000
        dataframe = DataFrame(language=["julia"], algorithm=[functionName], 
        filename=[file], 
        matrix_size=[s], 
        time=[millis])
        CSV.write("../benchmarks.csv", dataframe, append=true)
    end
end

function runBenchmarks()
    # writeTimes(5, "can_256.mtx", mult, "strassen")
    writeTimes(5, "can_256.mtx", mult, "strassen")
    # writeTimes(5,"delaunay_n10.mtx", )
    # writeTimes(5,"dw256B.mtx", )
    # writeTimes(5,"dwa512.mtx", )
    # writeTimes(5,"can_256.mtx", )
    # writeTimes(5,"dwt_512.mtx", )
    # writeTimes(5,"GD99_b.mtx", )
    # writeTimes(5,"gre_512.mtx", )
    # writeTimes(5,"Hamrle1.mtx", )
    # writeTimes(5,"ibm32.mtx", )

    # matrix = MatrixMarket.mmread("../matrices/can_256.mtx")
    # print(matrix)
    # strassen(matrix, matrix)
end

runBenchmarks()