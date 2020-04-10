module utils

using PyPlot
using Statistics: quantile

function pclip(array, perc)

    bclip = quantile(array[:],perc/100.0)    
    wclip = quantile(array[:],1.0 - perc/100.0)
    
    return wclip, bclip
end

function vminmax(a, perc, vmin, vmax)
    if vmin == nothing
        vmin, _ = pclip(a, perc)
    end

    if vmax == nothing
        _, vmax = pclip(a, perc)
    end

    if vmin > vmax
        vmin, vmax = vmax, vmin
    end

    return vmin, vmax
end

"""
    sisshow(img...; perc=99.0, vmin = nothing, vmax = nothing,
            cmap="Greys", interpolation="bicubic", vertical=false)

Plot 2D images

"""
function sisshow(img...; perc=99.0, vmin = nothing, vmax = nothing,
                 cmap="Greys", interpolation="bicubic", vertical=false)
    # Check array dimensions
    for i in img
        @assert(ndims(i) == 2, "Bidimensional arrays expected")
    end
    
    args = Dict(:cmap => cmap,
                :interpolation => interpolation)

    nplots = length(img)
    fig, axes = vertical ? subplots(nplots, 1) : subplots(1, nplots)

    for (i,a) in enumerate(img)
        vmin, vmax = vminmax(a, perc, vmin, vmax)
        if nplots == 1
            imshow(a, aspect="auto", vmin=vmin, vmax=vmax; args...)
            colorbar()
        else
            axes[i].imshow(a, aspect="equal", vmin=vmin, vmax=vmax; args...)
        end
    end
end

"""
    read_bin(filename::String, n::N)

Read binary 1D version, specifying dimension.
""" 
function read_bin(filename::String, n::N, T=Float32) where N<:Integer
    data = zeros(T, n)
    read!(filename, data)
    return data
end

"""
    read_bin(filename::String, n::N...)

Read binary N-D version, specifying dimension.
"""
function read_bin(filename::String, n::N...) where N<:Integer
    return reshape( read_bin( filename, prod(n) ), n)
end

end