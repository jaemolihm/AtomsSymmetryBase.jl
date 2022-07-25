using AtomsSymmetryBase
using Documenter

DocMeta.setdocmeta!(AtomsSymmetryBase, :DocTestSetup, :(using AtomsSymmetryBase); recursive=true)

makedocs(;
    modules=[AtomsSymmetryBase],
    authors="Jae-Mo Lihm <jaemolim96@gmail.com> and contributors",
    repo="https://github.com/Jae-Mo Lihm/AtomsSymmetryBase.jl/blob/{commit}{path}#{line}",
    sitename="AtomsSymmetryBase.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Jae-Mo Lihm.github.io/AtomsSymmetryBase.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Jae-Mo Lihm/AtomsSymmetryBase.jl",
    devbranch="main",
)
