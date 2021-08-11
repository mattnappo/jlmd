# -- Calculate the derivative of a function numerically using forward differentiation --
using Plots
using LinearAlgebra
import Base: *

const StrNum = Union{String, Number}
Base.:*(x::StrNum, y::StrNum) = string(x, y)

# Evaluate a function at n points on the given range.
function eval(f, n, r)
    dx = (r[2]-r[1])/n
    x = r[1]:dx:(r[2]-dx)
    y = f.(x)
    return x, y, dx
end

# Calculate a NxN matrix which will act as a differential operator.
function differentiation_matrix(n)
    d = zeros(n, n)
    for i in 1:(n-1)
        d[i,i]   = -1
        d[i,i+1] =  1
    end
    d[n,n-1] = -1
    d[n,n]   =  1
    return d
end

# Compute numerical results
range = [-2pi, 2pi]
n = 2100
f(k) = k^2 * sin(k)
x, y, dx = eval(f, n, range)
d = differentiation_matrix(n)

p1 = d * y  / dx # first derivative
p2 = d * p1 / dx # second derivative
p3 = d * p2 / dx # third derivative

# Analytic solution
f1(k) = k*(2sin(k) + k*cos(k))
f2(k) = 4k*cos(k) - (k^2 - 2)sin(k)
f3(k) = -(k^2 - 6)cos(k) - 6k*sin(k)

# Analysis

# Calculate the residual sum of squares
rss(x, y) = sum((y.-x).^2)
println("p1 error: " * rss(f1.(x), p1))
println("p2 error: " * rss(f2.(x), p2))
println("p3 error: " * rss(f3.(x), p3))

plot(x, [[p1 p2 p3], [f1.(x) f2.(x) f3.(x)]], layout=(3,1))
