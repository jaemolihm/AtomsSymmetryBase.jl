using AtomsSymmetryBase
using Test

@testset "SymOp" begin
    lattice = Mat3([3 0 0; 0 3 0; 0 0 3])
    W = Mat3([0 1 0; 0 0 1; 1 0 0])
    w = [0.1, 0.2, 0.3]
    symop = SymOp(W, w, false, lattice)
    @test symop.w ≈ -symop.W * symop.τ
    @test symop.wcart ≈ -symop.Wcart * symop.τcart
end