using Plots
using Distributed
using Folds

collatz(x) = 
    if iseven(x)
        x / 2
    else
        3x + 1
    end