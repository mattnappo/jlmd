using Distributions
using Plots

N = 10000 # number of steps
u = 0     # mean
o = 0.5   # standard deviation

pdf = Normal(u, o)

function walk1d()
    walk = zeros(N)
    for i = 2:N
        walk[i] = walk[i-1] + rand(pdf)
    end
    return walk
end

plot(walk1d(), walk1d(), walk1d())

#=
pdf = NormalInverseGaussian(u, 1, 1, o)
#walk = [cdf(pdf, rand()) for i = 1:N]
println(rand(pdf, 100))
# walk = collect(zip(rand(pdf, N), rand(pdf, N)))
function walk1d()
    x = [cdf(pdf, rand()) for i = 1:N]

    x_sums = zeros(N)
    x_sums[1] = x[1]
    for i = 2:N
        x_sums[i] = x_sums[i-1] + x[i]
    end

    return x
end

function walk2d()
    # return collect(zip(rw1d(), rw1d()))
end

walk_x = walk1d()
walk_y = walk1d()
walk_z = walk1d()

plot(walk_x, walk_y, walk_z)
=#

