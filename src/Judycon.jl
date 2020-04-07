module Judycon

import Base: union

include("quickfind.jl")
include("quickunion.jl")

export QuickFind, QuickUnion, connect!, isconnected, find

end
