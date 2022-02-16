using Rando, OmniSci, BenchmarkTools, Base.Threads

#change defaults, since examples long-running

BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1000

BenchmarkTools.DEFAULT_PARAMETERS.samples = 5

# generate test data 
endata(x, T) = [rand(typemin(T):typemax(T)) for y in 1:x]
gendata (generic function with 1 method)

int64_10x6 = gendata(10^6, Int64);

#Test whether broadcasting more/less efficient than pre-allocating results array
function preallocate(x)

    v = Vector{OmniSci.TStringValue}(undef, length(x))

    for idx in 1:length(x)
        v[idx] = OmniSci.TStringValue(x[idx])
    end

    return v
end

preallocate (generic function with 1 method)