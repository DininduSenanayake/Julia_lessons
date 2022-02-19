using OnlineStats: Means
e1 = Folds.reduce(Mean(), 1:10)

#Manual Reductions

using FLoops

@floop for (x,y) in zip(1:3, 1:2:6)
    a = x+y