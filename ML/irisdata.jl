# import a csv file
import Pkg; Pkg.add("CSV")
import Pkg; Pkg.add("DataFrames")
using CSV, DataFrames
iris = DataFrame(CSV.File("mypath//iris.csv"))

#prepare data
