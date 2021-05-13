using naive
using MatrixMarket
using strassens
using CSV
using sparse
# using BenchmarkTools


function writeTimes(n::integer,file::String, func::function, functionName::String)
    dir = "../matrices/"
    filename = dir + filename
    matrix = MatrixMarket.mmread(filename)
    for _ in 0:n
        time = @time func(matrix, matrix)
        CSV.write("../benchmarks.csv", 
        (language=["julia"], algorithm=[functionName], 
        filename=[file], 
        matrix_size=[size(matrix)], 
        time=[time]), append=true)
    end
end

function runBenchmarks()
    writeTimes(5,"can_256.mtx", )
    writeTimes(5,"delaunay_n10.mtx", )
    writeTimes(5,"dw256B.mtx", )
    writeTimes(5,"dwa512.mtx", )
    writeTimes(5,"can_256.mtx", )
    writeTimes(5,"dwt_512.mtx", )
    writeTimes(5,"GD99_b.mtx", )
    writeTimes(5,"gre_512.mtx", )
    writeTimes(5,"Hamrle1.mtx", )
    writeTimes(5,"ibm32.mtx", )

end