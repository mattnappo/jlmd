# Crank-nicolson diffusion of the heat equation in 3d

using Plots
using LinearAlgebra

nr = 300
nt = 300
dr = 1.0/(nr-1)
dt = 1/(nt-1)
nu = 2.4e-3
a = dr^2/(nu*dt)
r = LinRange(0, 1, nr)

# Initial Conditions
u = ones(nr)
u[nr] = 0
A = zeros((nr-2,nr-2))
B = zeros((nr-2,nr-2))

function edge(i)
    for j in 1:nr-2
        if j == 1
            return (2*i*(a+1), 2*i*(a-1))
        elseif j == 2
            return (-1-i, 1+i)
        else
            return (0, 0)
        end
    end
end

function boundary(i)
    for j in 1:nr-2
        if j == nr-3
            return (-1+i, i-1)
        elseif j == nr-4
            return (2*i*(a+1), 2*i*(a-1))
        else
            return (0, 0)
        end
    end
end

function middle(i)
    for j in 1:nr-2
        if j == i
            return (-i+1, i-1)
        elseif j == 2
            return (2*i*(a+1), 2*i*(a-1))
        else
            return (0, 0)
        end
    end
end

# Fill diffusion matricies
for k in 1:(nr-2)
    i = k + 1
    if k == 1
        v1, v2 = edge(i)
        A[k,:] .= v1
        B[k,:] .= v2
    elseif k == nr-3
        v1, v2 = middle(i)
        A[k,:] .= v1
        B[k,:] .= v2
    else
        v1, v2 = boundary(i)
        A[k,:] .= v1
        B[k,:] .= v2
   end
end

# Solve nu*dt/dr^2 = 1/a
for t in 1:nt
    u[1]  = 6/a * (u[2]-u[1]) + u[1]
    bb = B * u[1:nr-2]
    u[1:nr] = A\bb

    println(t, u[1], u[2], u[nr-2], u[nr-1])
end

plot(r, u)
