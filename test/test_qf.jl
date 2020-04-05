using Judycon, Test

#
# 1   2---3   4---5
# |   |   |   |   |
# 6---7   8   9   10
#

G = QuickFind(10);

connect!(G, 1, 2)
connect!(G, 1, 3)
connect!(G, 8, 7)
connect!(G, 6, 8)
connect!(G, 8, 3)

connect!(G, 10, 9)
connect!(G, 5, 4)
connect!(G, 5, 10)

# `pts1` should form one set of connected components and `pts2` another, respectively.
pts1 = [1, 2, 3, 6, 7, 8]
pts2 = [4, 5, 9, 10]
for p in pts1
    for q in pts1
        @test isconnected(G, p, q)
        @test isconnected(G, q, p)
    end
    for q in pts2
        @test !isconnected(G, p, q)
        @test !isconnected(G, q, p)
    end
end
