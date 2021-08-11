# ---- Use Verlet integration to solve Newton's equation for two bodies ----

using Plots

n = 20000 # calculation size

t  = zeros(n) # time
x  = zeros(n) # x pos
y  = zeros(n) # y pos
r  = zeros(n) # sqrt(x^2 + y^2)
v_x = zeros(n) # x vel
v_y = zeros(n) # y vel
a_x = zeros(n) # x acceleration
a_y = zeros(n) # y acceleration

# Parameters for the Halley comet and the sun
h = 2.0/(n-1) # Time step
h2 = h*h/2    # Cached
k = 39.478428 # k-value = GM

# Set initial values R_0, V_0, G_0
t[1]  = 0
x[1]  = 1.966843
y[1]  = 0
r[1]  = x[1]
v_x[1] = 0
v_y[1] = 0.815795
a_x[1] = -k / (r[1]^2)
a_y[1] = 0

# Solving for position and velocity of the next time step
for i = 1:(n-1)
    t[i+1] = h * (i+1)

    x[i+1] = x[i] + h * v_x[i] + h2 * a_x[i]
    y[i+1] = y[i] + h * v_y[i] + h2 * a_y[i]

    r2 = x[i+1]^2 + y[i+1]^2
    r[i+1] = sqrt(r2)
    r3 = r2 * r[i+1]

    a_x[i+1] = -k * x[i+1] / r3
    a_y[i+1] = -k * y[i+1] / r3

    v_x[i+1] = v_x[i] +h * (a_x[i+1] + a_x[i]) / 2
    v_y[i+1] = v_y[i] +h * (a_y[i+1] + a_y[i]) / 2
end

plot(t, r)
plot!(
    title = "Orbit of Halley around the Sun",
    xlabel = "time",
    ylabel = "radius from the sun",
)
