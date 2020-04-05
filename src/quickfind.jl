"""
    QuickFind
"""
struct QuickFind
    id :: Vector{Int}
end

function QuickFind(n::Int)
    id = Vector{Int}(undef, n)
    for i=1:n
        setindex!(id, i, i)
    end
    return QuickFind(id)
end

function find(qf::QuickFind, p::Int)
    id = getfield(qf, :id)
    pid = getindex(id, p)
    return pid
end

function isconnected(qf::QuickFind, p::Int, q::Int)
    pid = find(qf, p)
    qid = find(qf, q)
    return isequal(pid, qid)
end

function connect!(qf::QuickFind, p::Int, q::Int)
    id = getfield(qf, :id)
    pid = getindex(id, p)
    qid = getindex(id, q)
    for i=1:length(id)
        if isequal(getindex(id, i), pid)
            setindex!(id, qid, i)
        end
    end
    return
end
