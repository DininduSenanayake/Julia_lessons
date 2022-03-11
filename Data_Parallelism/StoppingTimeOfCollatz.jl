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

plot =  scatter(
    map(collatz_stopping_time, 1:10_100),
    xlabel = "Initial value",
    ylabel = "Stopping time",
    label = "",
    markercolor = 1,
    markerstrokecolor = 1, 
    markersize = 3,
    size = (450 , 300),
)

#permissions check