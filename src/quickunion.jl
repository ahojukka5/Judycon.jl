"""
    QuickUnion
"""
struct QuickUnion
    id :: Vector{Int}
end

function QuickUnion(n::Int)
    id = Vector{Int}(undef, n)
    for i=1:n
        setindex!(id, i, i)
    end
    return QuickUnion(id)
end

function root(G::QuickUnion, i::Int)
    id = getfield(G, :id)
    while i != id[i]
        i = id[i]
    end
    return i
end

function find(G::QuickUnion, p::Int)
    return root(G, p)
end

function isconnected(G::QuickUnion, p::Int, q::Int)
    return isequal(find(G, p), find(G, q))
end

function connect!(G::QuickUnion, p::Int, q::Int)
    id = getfield(G, :id)
    i::Int = root(G, p)
    j::Int = root(G, q)
    id = getfield(G, :id)
    id[i] = j
    return
end
