![Judycon.jl](demos/percolation.gif)

[![][travis-img]][travis-url]
[![][coveralls-img]][coveralls-url]
[![][docs-stable-img]][docs-stable-url]
[![][docs-dev-img]][docs-dev-url]

Package author: Jukka Aho (@ahojukka5)

Judycon.jl implements dynamic connectivity algorithms for Julia programming
language. In computing and graph theory, a [dynamic connectivity structure][1]
is a data structure that dynamically maintains information about the connected
components of a graph. Dynamic connectivity has a lot of applications. For
example, dynamic connetivity [can be used][2] to determine functional
connectivity change points in fMRI data. In the top of this readme, you see a
percolation model which is solved using the functions provided this package. For
more information about the model and the package, see the documentation. Project
documentation is found from url <https://ahojukka5.github.io/Judycon.jl/dev/>.

## Usage

The following two algoritms are implemented:

- QuickFind
- QuickUnion

Both of the algorithms have same API, but the internal data structure is
different. Typical use case is:

```julia
using Judycon: QuickFind, QuickUnion, connect!, isconnected

wuf = QuickUnion(10)
connect!(wuf, 1, 2)
connect!(wuf, 2, 3)
connect!(wuf, 3, 4)
isconnected(wuf, 1, 4)

# output

true
```

For further information about the implementation details and usage, please see
the [documentation][docs-dev-url].

QuickFind is a simple data structure making it possible to very fast query, does
points p and q belong to the same connected component, but connecting the points
is slow, up to ~ N^2 in the worst case.

QuickUnion makes it fast to connect points. Finding points is not that fast than
with QuickFind, but with some common modifications, i.e. weighting and path
compression, it gives good a performance.

Weighted quick union with path compression makes it possible to solve problems
that could not otherwise be addressed. In case of doubt which suits for your
need, use that.

The performance of the algorithms (M union-find operations on a set of N object)
is given below.

| algorithm                      | worst-case time |
| ------------------------------ | --------------- |
| quick-find                     | M N             |
| quick-union                    | M N             |
| weighted QU                    | M + N log N     |
| QU + path compression          | M + N log N     |
| weighted QU + path compression | N + M lg N      |

## Dynamic connectivity application: percolation

Source: <https://en.wikipedia.org/wiki/Percolation>

In physics, chemistry and materials science, percolation (from Latin percōlāre,
"to filter" or "trickle through") refers to the movement and filtering of fluids
through porous materials. It is described by Darcy's law. Broader applications
have since been developed that cover connectivity of many systems modeled as
lattices or graphs, analogous to connectivity of lattice components in the
filtration problem that modulates capacity for percolation.

During the last decades, percolation theory, the mathematical study of
percolation, has brought new understanding and techniques to a broad range of
topics in physics, materials science, complex networks, epidemiology, and other
fields. For example, in geology, percolation refers to filtration of water
through soil and permeable rocks. The water flows to recharge the groundwater in
the water table and aquifers. In places where infiltration basins or septic
drain fields are planned to dispose of substantial amounts of water, a
percolation test is needed beforehand to determine whether the intended
structure is likely to succeed or fail.

Percolation typically exhibits universality. Statistical physics concepts such
as scaling theory, renormalization, phase transition, critical phenomena and
fractals are used to characterize percolation properties. Percolation is the
downward movement of water through pores and other spaces in the soil due to
gravity. Combinatorics is commonly employed to study percolation thresholds.

Due to the complexity involved in obtaining exact results from analytical models
of percolation, computer simulations are typically used. The current fastest
algorithm for percolation was published in 2000 by Mark Newman and Robert
Ziff.

### Use cases of percolation model

- Coffee percolation, where the solvent is water, the permeable substance is
  the coffee grounds, and the soluble constituents are the chemical compounds
  that give coffee its color, taste, and aroma.
- Movement of weathered material down on a slope under the earth's surface.
- Cracking of trees with the presence of two conditions, sunlight and under
  the influence of pressure.
- Collapse and robustness of biological virus shells to random subunit removal
  (experimentally verified fragmentation and disassembly of viruses).
- Robustness of networks to random and targeted attacks.
- Transport in porous media.
- Epidemic spreading.
- Surface roughening.
- Dental percolation, increase rate of decay under crowns because of a
  conducive environment for strep mutants and lactobacillus
- Potential sites for septic systems are tested by the "perk test".
  Example/theory: A hole (usually 6–10 inches in diameter) is dug in the ground
  surface (usually 12–24" deep). Water is filled in to the hole, and the time is
  measured for a drop of one inch in the water surface. If the water surface
  quickly drops, as usually seen in poorly-graded sands, then it is a potentially
  good place for a septic "leach field". If the hydraulic conductivity of the
  site is low (usually in clayey and loamy soils), then the site is undesirable.
- Traffic percolation.

From `demos`, you find a percolation model implemented using Judycon.jl The
development of system from initial state to percolation is animated in the top
of this file.

[1]: https://en.wikipedia.org/wiki/Dynamic_connectivity
[2]: https://www.frontiersin.org/articles/10.3389/fnins.2015.00285/full
[travis-img]: https://travis-ci.org/ahojukka5/Judycon.jl.svg?branch=master
[travis-url]: https://travis-ci.org/ahojukka5/Judycon.jl
[coveralls-img]: https://coveralls.io/repos/github/ahojukka5/Judycon.jl/badge.svg?branch=master
[coveralls-url]: https://coveralls.io/github/ahojukka5/Judycon.jl?branch=master
[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://ahojukka5.github.io/Judycon.jl/dev
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://ahojukka5.github.io/Judycon.jl/stable
