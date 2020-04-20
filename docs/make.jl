using Judycon, Documenter

makedocs(modules=[Judycon],
         format = Documenter.HTML(),
         checkdocs = :all,
         sitename = "Judycon.jl",
         pages = ["index.md"])
