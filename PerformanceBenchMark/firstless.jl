using Rando, OmniSci, BenchmarkTools, Base.Threads

#change defaults, since examples long-running

BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1000

BenchmarkTools.DEFAULT_PARAMETERS.samples = 5

# generate test data 
endata(x, T) = [rand(typemin(T):typemax(T)) for y in 1:x]
gendata (generic function with 1 method)

int64_10x6 = gendata(10^6, Int64);