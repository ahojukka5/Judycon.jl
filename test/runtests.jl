using Judycon, Test

#
# 1   2---3   4---5
# |   |   |   |   |
# 6---7   8   9   10
#

G1 = QuickFind(10);
G2 = QuickUnion(10, false, false);
G3 = QuickUnion(10, true, false);
G4 = QuickUnion(10, false, true);
G5 = QuickUnion(10, true, true);

function test(G)

    connect!(G, 1, 6)
    connect!(G, 6, 7)
    connect!(G, 7, 2)
    connect!(G, 2, 3)
    connect!(G, 3, 8)
    
    connect!(G, 9, 4)
    connect!(G, 4, 5)
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
end

@testset "Test Judycon.jl" begin
    @testset "Test QuickFind" begin test(G1) end
    @testset "Test QuickUnion without weighting and path compression" begin test(G2) end
    @testset "Test QuickUnion with weighting and without path compression" begin test(G3) end
    @testset "Test QuickUnion without weighting and with path compression" begin test(G4) end
    @testset "Test QuickUnion with weighting and path compression" begin test(G5) end
end

