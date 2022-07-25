using AtomsSymmetryBase
using AtomsBase
using Unitful
using Test

@testset "AtomsBase to Spglib.Cell" begin
    lattice = [[10, 0.0, 0.0], [0.0, 5, 0.0], [0.0, 0.0, 7]]u"Å"
    atoms = [:Si => [0.0, -0.125, 0.0],
             :C  => [0.125, 0.0, 0.0],]
    system = periodic_system(atoms, lattice; fractional=true)

    cell = AtomsSymmetryBase.system_to_cell(system)

    @test cell.lattice[:, 1] ≈ ustrip.(lattice[1])
    @test cell.lattice[:, 2] ≈ ustrip.(lattice[2])
    @test cell.lattice[:, 3] ≈ ustrip.(lattice[3])
    @test cell.positions[:, 1] ≈ atoms[1][2]
    @test cell.positions[:, 2] ≈ atoms[2][2]
    @test cell.types == [:Si, :C]
    @test cell.magmoms == [0., 0.]
end