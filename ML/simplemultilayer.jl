# extraced from  https://fluxml.ai/tutorials/2021/01/26/mlp.html

#Load packages
using Flux, Statistics
using Flux.Data: DataLoader
using Flux: onehotbatch, onecold, logitcrossentropy, throttle, @epochs
using Base.Iterators: repeated
using Parameters: @with_kw
using CUDA
using MLDatasets
if has_cuda()		# Check if CUDA is available
    @info "CUDA is on"
    CUDA.allowscalar(false)
end

#We set default values for learning rate, batch size, epochs, and the usage of a GPU (if available) for our model:

    @with_kw mutable struct Args
        η::Float64 = 3e-4       # learning rate
        batchsize::Int = 1024   # batch size
        epochs::Int = 10        # number of epochs
        device::Function = gpu  # set as gpu, if gpu available
    end
    
#Data
#We create the function getdata to load the MNIST train and test data sets
#Prepare the for training process



function getdata(args)
    ENV["DATADEPS_ALWAYS_ACCEPT"] = "true"

    # Loading Dataset	
    xtrain, ytrain = MLDatasets.MNIST.traindata(Float32)
    xtest, ytest = MLDatasets.MNIST.testdata(Float32)
	
    # Reshape Data in order to flatten each image into a linear array
    xtrain = Flux.flatten(xtrain)
    xtest = Flux.flatten(xtest)

        # One-hot-encode the labels
        ytrain, ytest = onehotbatch(ytrain, 0:9), onehotbatch(ytest, 0:9)

        # Batching
        train_data = DataLoader((xtrain, ytrain), batchsize=args.batchsize, shuffle=true)
        test_data = DataLoader((xtest, ytest), batchsize=args.batchsize)
    
        return train_data, test_data
end

#model
function build_model(; imgsize=(28,28,1), nclasses=10)
    return Chain(
 	    Dense(prod(imgsize), 32, relu),
            Dense(32, nclasses))
end

#Loss functions
function loss_all(dataloader, model)
    l = 0f0
    for (x,y) in dataloader
        l += logitcrossentropy(model(x), y)
    end
    l/length(dataloader)
end

function accuracy(data_loader, model)
    acc = 0
    for (x,y) in data_loader
        acc += sum(onecold(cpu(model(x))) .== onecold(cpu(y)))*1 / size(x,2)
    end
    acc/length(data_loader)
end

#Train our model
function train(; kws...)
    # Initializing Model parameters 
    args = Args(; kws...)

    # Load Data
    train_data,test_data = getdata(args)

    # Construct model
    m = build_model()
    train_data = args.device.(train_data)
    test_data = args.device.(test_data)
    m = args.device(m)
    loss(x,y) = logitcrossentropy(m(x), y)

    ## Training
    evalcb = () -> @show(loss_all(train_data, m))
    opt = ADAM(args.η)