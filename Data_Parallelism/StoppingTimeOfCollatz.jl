using Plots
using Distributed
using Folds

collatz(x) = 
    if iseven(x)
        x / 2
    else
        3x + 1
    end

function collatz_stopping_time(x)
    n = 0
    while true
        x ==1 && return 
        n += 1
        x = collatz(x)
    end 
end