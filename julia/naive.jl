# credit: https://andrew.gibiansky.com/blog/mathematics/matrix-multiplication/

# Standard matrix multiplication algorithm. 
function mult{T}(x :: Matrix{T}, y :: Matrix{T})
    # Check that the sizes of these matrices match.
    (r1, c1) = size(x)
    (r2, c2) = size(y)
    if c1 != r2
        error("Multiplying $r1 x $c1 and $r2 x $c2 matrix: dimensions do not match.")
    end
    
    # Get value at (i, j)th cell by taking the dot product
    # of the ith row of the first matrix and the jth column of the second.
    function at(i, j)
        accum = x[i, 1] * y[1, j]
        for k = 2:c1
            accum += x[i, k] * y[k, j]
        end
        accum
    end
    T[at(i, j) for i = 1:r1, j = 1:c2]
end;