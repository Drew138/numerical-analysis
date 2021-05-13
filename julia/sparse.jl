function convertToMapRepresentation(A::Matrix)
    map = Dict()
    for i in range(siz(A))
        for j in range(size(A[i]))
            if A[i][j] != 0
                map[(i, j)] = A[i][j]
            end
        end
    end
    return map
end

function sparseMultiplication(A::Matrix, B::Matrix)
    DictA = convertToMapRepresentation(A) 
    DictB = convertToMapRepresentation(B)
    DictC = Dict()
    for (key, val) in DictA
        for (key2, val2) in DictB
            if key[1] == key2[0]
                C[(key[0], key2[1])] = val * val2
            end
        end
    end
    return DictC    
end