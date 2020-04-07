using Test

@testset "Test Judycon.jl" begin
    @testset "Test QuickFind" begin include("test_qf.jl") end
    @testset "Test QuickUnion" begin include("test_qu.jl") end
end
