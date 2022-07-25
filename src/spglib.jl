using AtomsBase
using Unitful
using Spglib

normalize_magnetic_moment(::Nothing)::Float64    = 0
normalize_magnetic_moment(mm::Number)::Float64   = mm
normalize_magnetic_moment(mm::AbstractVector)::Vec3{Float64} = mm

function system_to_cell(system::AbstractSystem{D}) where {D}
    @assert D == 3
    if !all(periodicity(system))
        error("AtomsSymmetryBase only supports systems with periodic boundary conditions.")
    end

    lattice = ustrip.(reduce(hcat, bounding_box(system)))
    T = eltype(lattice)

    positions = map(system) do atom
        coordinate = zeros(T, 3)
        coordinate[1:D] = lattice[1:D, 1:D] \ T.(ustrip.(position(atom)))
        Vec3{T}(coordinate)
    end::Vector{Vec3{T}}

    types = atomic_symbol(system)

    magnetic_moments = map(system) do atom
        hasproperty(atom, :magnetic_moment) || return nothing
        getproperty(atom, :magnetic_moment)
    end
    magnetic_moments = normalize_magnetic_moment.(magnetic_moments)

    Spglib.Cell(lattice, positions, types, magnetic_moments)
end