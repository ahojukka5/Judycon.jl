module PercolationModel

using Judycon
import Judycon: connect!

struct Percolation
    grid :: Matrix{Bool}
    li :: LinearIndices
    dim :: Int
    wuf1 :: QuickUnion
    wuf2 :: QuickUnion
    topnode :: Int
    bottomnode :: Int
end

function Percolation(dim)
    grid = zeros(Bool, dim, dim)
    li = LinearIndices(grid)
    wuf1 = QuickUnion(dim^2+2)
    wuf2 = QuickUnion(dim^2+1)
    topnode = dim^2 + 1
    bottomnode = topnode + 1
    return Percolation(grid, li, dim, wuf1, wuf2, topnode, bottomnode)
end

function connect!(p::Percolation, i, j)
    connect!(p.wuf1, i, j)
    connect!(p.wuf2, i, j)
end

function isopen(p::Percolation, i, j)
    return p.grid[i,j]
end

function number_of_open(p::Percolation)
    return sum(p.grid)
end

function isfull(p::Percolation, i, j)
    !isopen(p, i, j) && return false
    return isconnected(p.wuf2, p.topnode, p.li[i,j])
end

function percolates(p::Percolation)
    return isconnected(p.wuf1, p.topnode, p.bottomnode)
end

function open!(p::Percolation, i, j)
    isopen(p, i, j) && return
    p.grid[i, j] = true
    i == 1      && connect!(p, p.topnode, p.li[i, j])
    i == p.dim  && connect!(p.wuf1, p.bottomnode, p.li[i, j])
    i > 1       && isopen(p, i-1, j) && connect!(p, p.li[i,j], p.li[i-1, j])
    i < p.dim-1 && isopen(p, i+1, j) && connect!(p, p.li[i,j], p.li[i+1, j])
    j > 1       && isopen(p, i, j-1) && connect!(p, p.li[i,j], p.li[i, j-1])
    j < p.dim-1 && isopen(p, i, j+1) && connect!(p, p.li[i,j], p.li[i, j+1])
end

using Statistics

struct Result{T}
    samples :: Vector{T}
    mean :: Float64
    stddev :: Float64
    confidence_lo :: Float64
    confidence_hi :: Float64
end

const CONFIDENCE_95 = 1.96

function Result(samples)
    n = length(samples)
    m = mean(samples)
    s = std(samples)
    cl = m - CONFIDENCE_95 * s / sqrt(n)
    ch = m + CONFIDENCE_95 * s / sqrt(n)
    return Result(samples, m, s, cl, ch)
end

using Printf

function Base.show(io::IO, r::Result)
    @printf("% 25s =  %d\n", "samples", length(r.samples))
    @printf("% 25s =  %0.3f\n", "mean", r.mean)
    @printf("% 25s =  %0.3f\n", "stddev", r.stddev)
    @printf("% 25s = [%0.3f, %0.3f]\n", "95% confidence interval", r.confidence_lo, r.confidence_hi)
end

function run_one(n)
    p = Percolation(n)
    while !percolates(p)
        open!(p, rand(1:n), rand(1:n))
    end
    return p
end

function run(n, trials)
    thresholds = zeros(trials)
    for i=1:trials
        p = run_one(n)
        thresholds[i] = number_of_open(p) / n^2
    end
    return Result(thresholds)
end

end