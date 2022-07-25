using AtomsSymmetryBase
using Test

@testset "AtomsSymmetryBase.jl" begin
    include("test_SymOp.jl")
    include("test_spglib.jl")
end
