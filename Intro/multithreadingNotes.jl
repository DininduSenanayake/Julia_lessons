# notes are from http://www.cs.unb.ca/~aubanel/JuliaMultithreadingNotes.html

#The Julia function returns an 8 bit integer, given the limited range of values.

function juliaSetPixel(z0, c)
    z = z0
    niter = 255
    for i in 1:niter
        abs2(z)> 4.0 && return (i - 1)%UInt8
        z = z*z + c
    end
    return niter%UInt8
end

#Calculation of one column of the image is computed with the following function:
function calcColumn!(pic, c, n, j)
    x = -2.0 + (j-1)*4.0/(n-1)
    for i in 1:n
        y = -2.0 + (i-1)*4.0/(n-1)
        @inbounds pic[i,j] = juliaSetPixel(x+im*y, c)
    end
    nothing
end

#where it can be seen that the image has n x n pixels and the range of the coordinates is from -2 to 2. Calculation of the entire fractal is given by:

function juliaSetCalc!(pic,c,n)
    for j in 1:n
        calcColumn!(pic,c,n,j)
    end
    nothing
end

#More in the next section on why this decomposition into columns has been used. Here is the driver function to generate the fractal:

function juliaSet(x,y,n=1000,method = juliaSetCalc!, extra...)
    c = x +x*im
    pic = Array{UInt8,2}(undef,n,n)
    method(pic,c,n,extra...)
    return pic
end

#=This function allows different parallel versions of the fractal calculation to be passed as a parameter, and the varargs (C programmers will know about this) parameter extra... allows for differences in the number of parameters.

The fractal can be visualized using the heatmap function of the the Plots.jl package. Here is the fractal for c=−.79+0.15i
:
=#

frac = juliaSet(-0.79 , 0.15)
using Plots
plot(heatmap(1:size(frac,1),1:size(frac,2),frac,color=:Spectral))

#run again to see the execution time

using BenchmarkTools
@btime juliaSet(-0.79,0.15)