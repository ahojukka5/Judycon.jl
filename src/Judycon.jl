module Judycon

"""
    QuickFind
"""
struct QuickFind
    id :: Vector{Int}
end

function QuickFind(n::Int)
    id = collect(1:n)
    return QuickFind(id)
end

function find(qf::QuickFind, p::Int)
    id = qf.id
    return id[p]
end

function isconnected(qf::QuickFind, p::Int, q::Int)
    i = find(qf, p)
    j = find(qf, q)
    return isequal(i, j)
end

function connect!(qf::QuickFind, p::Int, q::Int)
    id = qf.id
    pid = id[p]
    qid = id[q]
    n = length(id)
    for i=1:n
        if isequal(getindex(id, i), pid)
            setindex!(id, qid, i)
        end
    end
    return
end

"""
    QuickUnion
"""
struct QuickUnion
    id :: Vector{Int}
    sz :: Vector{Int}
    weighted :: Bool
    compress :: Bool
end

function QuickUnion(n::Int, weighted=true, compress=true)
    id = collect(1:n)
    sz = zeros(Int, n)
    return QuickUnion(id, sz, weighted, compress)
end

function find(qu::QuickUnion, p::Int)
    id = qu.id
    while p != id[p]
        if qu.compress
            id[p] = id[id[p]]
        end
        p = id[p]
    end
    return p
end

function isconnected(qu::QuickUnion, p::Int, q::Int)
    i = find(qu, p)
    j = find(qu, q)
    return isequal(i, j)
end

"""
    connect(G, p, q)

Connect p and q in G.

If weighting is used, connect such a way that the depth of the tree is minimized.
"""
function connect!(qu::QuickUnion, p::Int, q::Int)
    id = qu.id
    i = find(qu, p)
    j = find(qu, q)
    if qu.weighted
        sz = qu.sz
        if (sz[i] < sz[j])
            id[i] = j
            sz[j] += sz[i]
        else
            id[j] = i
            sz[i] += sz[j]
        end
    else
        id[i] = j
    end
end

export QuickFind, QuickUnion, connect!, isconnected, find

end
