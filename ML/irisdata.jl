# import a csv file
import Pkg; Pkg.add("CSV")
import Pkg; Pkg.add("DataFrames")
using CSV, DataFrames
iris = DataFrame(CSV.File("mypath//iris.csv"))

#prepare data
import Pkg; Pkg.add("Lathe")
using Lathe
scaled_feature = Lathe.preprocess.OneHotEncode(iris,:variety)
iris = select!(iris, Not([:variety]))
first(iris,5)

#data preparation :  Train test split
using Random
sample = randsubseq(1:size(iris,1), 0.75)
train = iris[sample, :]
notsample = [i for i in 1:size(iris,1) if isempty(searchsorted(sample, i))]
test = iris[notsample, :]