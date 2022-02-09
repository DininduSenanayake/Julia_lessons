# extraced from https://fluxml.ai/tutorials/2021/01/26/mlp.html

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

We set default values for learning rate, batch size, epochs, and the usage of a GPU (if available) for our model:

    @with_kw mutable struct Args
        η::Float64 = 3e-4       # learning rate
        batchsize::Int = 1024   # batch size
        epochs::Int = 10        # number of epochs
        device::Function = gpu  # set as gpu, if gpu available
    end
    