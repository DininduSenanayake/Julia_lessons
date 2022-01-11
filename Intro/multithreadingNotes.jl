function juliaSetPixel(z0, c)
    z = z0
    niter = 255
    for i in 1:niter
        abs2(z)> 4.0 && return (i - 1)%UInt8
        z = z*z + c
    end
    return niter%UInt8
end

function calcColumn!(pic, c, n, j)
    x = -2.0 + (j-1)*4.0/(n-1)
    for i in 1:n
        y = -2.0 + (i-1)*4.0/(n-1)
        @inbounds pic[i,j] = juliaSetPixel(x+im*y, c)
    end
    nothing
end
