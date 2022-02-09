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