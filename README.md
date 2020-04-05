# Judycon.jl

Package implements dynamic connectivity algorithms for Julia programming
language. In computing and graph theory, a [dynamic connectivity structure][1]
is a data structure that dynamically maintains information about the connected
components of a graph.

Dynamic connectivity has a lot of applications. For example, dynamic connetivity
[can be used][2] to determine functional connectivity change points in fMRI
data.

## Implemented algorithms:

- QuickFind

### QuickFind

Quick-find is a simple implementation where 1d array is used as a internal data
structure to describe the connectivity. In initial state, we have array
consisting the same value than index,

```
id  1 2 3 4 5 6 7 8 9 10
val 1 2 3 4 5 6 7 8 9 10
```

Now, to connect node 1 to node 2, node 2 to node 3, and node 3 to node 4, array
is

```
id  1 2 3 4 5 6 7 8 9 10
val 4 4 4 4 5 6 7 8 9 10
```

That is, value of array describes the connectivity. For example, 1 and 4 are
connected, because `id[1] == id[4]`.

In initialization, we must give the size of the graph:

```julia
qf = QuickFind(10)
connect!(qf, 1, 2)
connect!(qf, 2, 3)
connect!(qf, 3, 4)
isconnected(qf, 1, 4)

# output

true
```

In general, quick-find is considered to be too slow. Time complexity is linear
in initialization, and in union, the worst-case scenario is N^2. Thus quick-find
algorithm is not having a lot of practical applications in high-performance
computing. However, as name suggest, finding a connection (after potentially N^2
expensive union) is cheap.

[1]: https://en.wikipedia.org/wiki/Dynamic_connectivity
[2]: https://www.frontiersin.org/articles/10.3389/fnins.2015.00285/full
