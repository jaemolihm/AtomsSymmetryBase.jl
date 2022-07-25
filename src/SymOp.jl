using StaticArrays
using LinearAlgebra

const Mat3{T} = SMatrix{3, 3, T, 9} where T
const Vec3{T} = SVector{3, T} where T

struct SymOp{T}
    # Real space lattice vector. lattice[:, i] is the i-th lattice vector.
    lattice::Mat3{T}

    # (Uu)(x) = u(W x + w) in real space
    W::Mat3{Int}
    w::Vec3{T}

    # (Uu)(G) = e^{-i G τ} u(S^-1 G) in reciprocal space, reduced coordiantes
    S::Mat3{Int}
    τ::Vec3{T}

    # S and τ in cartesian coordinates
    Wcart::Mat3{T}
    wcart::Vec3{T}

    # S and τ in cartesian coordinates
    Scart::Mat3{T}
    τcart::Vec3{T}

    # Reflection (det(S) < 0)
    reflection::Bool
    # Time reversal
    tr::Bool
end

function SymOp(W, w::AbstractVector{T}, tr, lattice) where {T}
    w = mod.(w, 1)
    S = W'
    τ = -W \ w
    Scart = inv(lattice') * S * lattice'
    τcart = lattice * τ
    Wcart = lattice * W * inv(lattice)
    wcart = lattice * w
    reflection = det(S) < 0
    SymOp{T}(lattice, W, w, S, τ, Wcart, wcart, Scart, τcart, reflection, tr)
end
