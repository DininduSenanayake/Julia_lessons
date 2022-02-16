using Rando, OmniSci, BenchmarkTools, Base.Threads

#change defaults, since exaples long-running

BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1000

BenchmarkTools.DEFAULT_PARAMETERS.samples = 5

# generate test data 
