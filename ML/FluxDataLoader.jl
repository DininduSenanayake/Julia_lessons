Pkg.add("Flux")
Pkg.add("MLDatasets")

using MLDatasets: MNIST
using Flux.Data: DataLoaded
using Flux: onehotbatch

#loading the MNIST data set
train_x, train_y = MNIST.traindata(Float32)
test_x, test_y = MNIST.testdata(Float32)

#Step 2: Loading the dataset onto DataLoader

train_x = reshape(train_x, 28, 28, 1, :)
test_x = reshape(test_x, 28, 28, 1, :)

train_y, test_y = onehotbatch(train_y, 0:9), onehotbatch(test_y, 0:9)
data_loader = DataLoader(train_x, train_y, batchsize=128, shuffle=true)