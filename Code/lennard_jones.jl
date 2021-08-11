using StaticArrays
using Calculus
using Plots
using Unitful
using BenchmarkTools
import Printf.@printf

# -- Simulate a blob of argon atoms assuming a Lennard Jones 12-6 potential --

N = 100      # N of particles in the system
L = 20       # Size of the box

e = 0.997    # dispersion energy
o = 3.40     # particle size
m = 39.948   # particle mass
T = 319.261  # initial temp

# A and B values for optimizing LJP calculations
A = 4e * o^12
B = 4e * o^6

LJ(r) = (A/r^12 - B/r^6)
LJSlow(r) = 4e*( (o/r)^12 - (o/r)^6 ) # lol

SA_F32[1, 2, 3.2] isa SVector{3, Float32}

function plot_lj()
    r = -1.0:0.01:1.0
    plot(x, LJ.(r))
    plot!(title = "LJ Potential")
end

x = -1.0:0.01:1.0
# @btime LJ.(x)
# @btime LJSlow.(x)

# Apply the Gaussian distribution to two uniform random numbers between [0, 1]
function RandomGaussian()
    r = rand(2)
    gx = sqrt(2 * -log(1-r[1]))
    gy = 2pi*r[2]
    return gx*cos(gy), gx*sin(gy)
end

function Gaussian(t1, t2)
    g1 = sqrt(2 * -log(1-t1))
    g2 = 2pi*t2
    return g1*cos(g2), g1*sin(g2)
end

t = 0:0.0001:1 # 10001 points
g = zeros(10001)

for i = 1:2:10000
    g[i], g[i+1] = Gaussian(t[i], t[i+1])
end

# Return the velocities of N particles of mass m in a system with temperature T
# based on their Maxwell distribution
function MaxwellDistVels(m, T, N)
    idf = 3 * N    # independent degrees of freedom
    df = idf - 6   # total degrees of freedom
    @printf "%.2f %.2f\n" idf df

    # Assign a Gaussian number to each velocity component
    for i = 1:idf
        r = RandomGaussian()
        g[i] = r[1]
        g[i+1] = r[2]
    end

    # Scale the velocity to satisfy the partition theorem
    ek = 0
    for i = 1:idf
        ek += g[i]^2
    end

    vs = sqrt( m * ek * idf / (df*T) )
    return g ./ vs
end

# The particles initial vals
r = MaxwellDistVels(m, T, N)

plot(t, [r g], layout=(1,2))

# Then calculate the movement physics per time step
# ...

