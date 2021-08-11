# Julia Molecular Dynamics
This repo holds the Julia code for my molecular dynamics research project. The main project [can be found here](https://github.com/xoreo/md).

I wrote [these notes](https://github.com/xoreo/jlmd/Notes/notes.pdf), which outline the physics behind molecular dynamics simulations. It is very helpful to read them.

This project contains four code examples:
* A somewhat efficient implementation of automatic differentiation
  * [Code](https://github.com/xoreo/jlmd/Code/automatic_differentiation.jl)
  * [Reference](https://en.wikipedia.org/wiki/Automatic_differentiation)
* A two-body MD simulation of the Halley Comet wrt the Sun using Verlet integration
  * [Code](https://github.com/xoreo/jlmd/Code/halley_sun.jl)
  * [Reference](https://en.wikipedia.org/wiki/Verlet_integration)
* A numerical solution to the heat equation using the Crank Nicolson method in 3D
  * [Code](https://github.com/xoreo/jlmd/Code/crank_nicolson_3d.jl)
  * [Reference](https://en.wikipedia.org/wiki/Heat_equation)
* A real molecular dynamics simulation of atoms behaving as Lennard Jones 12-6 potential.
  * [Code](https://github.com/xoreo/jlmd/Code/lennard_jones.jl)
  * [Reference](https://en.wikipedia.org/wiki/Lennard-Jones_potential)
  * Note: this is incomplete. It is more complete in the Python version in the main repo.

Dowland: Looking back on this code from over a year ago, I realize how non-idiomatic and shit some of it is lol. Sorry if this is underwhelming.
