##### Modeling pandemic with ordinary differential equations
# N: population size
# S: the number of susceptible individuals
# I: the number of infectious individuals
# R: the number of recovered (immuned) individuals
# dS/dt = - beta*I*S/N
# dI/dt =   beta*I*S/N - gamma*I
# dR/dt =                gamma*I
# s.t. dS/dt + dI/dt + dR/dt = 0, i.e. S + I + R = N
#
# According to https://cran.r-project.org/web/packages/shinySIR/vignettes/Vignette.html
# beta is the transmission rate and beta*I*S represents the number of susceptible individuals that become infected per day
# gamma is the recovery rate and gamma*I is the number of infected individuals that recover per day. 
# 1/gamma is the infectious period, i.e. the average duration of time an individual can remain infected.
#
# To be realistic, consider a constant birth rate, mu, the model becomes
# dS/dt = mu*(N-S) - beta*I*S/N
# dI/dt =            beta*I*S/N - (gamma+mu)*I
# dR/dt =                              gamma*I - mu*R
#
# The dynamic of the infectious class depends on the ratio:
# R_0 = beta/(gamma+mu) ... basic reproduction number
# The effective reproductive ratio is R_0*S/N, when less than 1 the disease starts to decrease.

mu = 0
beta = 2
gamma = 1/2

epsilon = 0.001
N = 1
S = 1-epsilon
I = epsilon
R = 0

# Use the ode solver; dZ/dt = SIR(Z)
p = c(mu = 0, N = 1, beta = 2, gamma = 1/2)
start_SIR = c(S = 1-epsilon, I = epsilon, R = 0)

# Define time and function that returns gradients
times = seq(0, 10, by = .1)
SIR = function(t,Z,p) {
  S=Z[1]; I=Z[2]; R=Z[3]; N=S+I+R; mu=p["mu"]; beta=p["beta"]; gamma=p["gamma"]
  dS = mu*(N-S) - beta*S*I/N
  dI =            beta*S*I/N - (mu+gamma)*I
  dR =                              gamma*I - mu*R
  dZ = c(dS,dI,dR)
  return(list(dZ))
}

library(deSolve)
resol = ode(y=start_SIR, times=times, func=SIR, parms=p)

##### Visualization the Dynamics and the R_0
par(mfrow=c(1,2))
t = resol[,"time"]

plot(t, resol[,"S"], type="l", xlab="time", ylab="")
lines(t, resol[,"I"], col="red")
lines(t, resol[,"R"], col="blue")

plot(t, t*0+1, type="l", xlab="time", ylab="", ylim=0:1)
polygon(c(t, rev(t)), c(resol[,"R"], rep(0,nrow(resol))), col="blue")
polygon(c(t, rev(t)), c(resol[,"R"] + resol[,"I"], rev(resol[,"R"])), col="red")

# The left is probability at the time, the right is cumulative cases over time.

R0=p["beta"]/(p["gamma"]+p["mu"])

plot(t, resol[,"S"]*R0, type="l", xlab="time", ylab="")
abline(h=1, lty=2, col="red")
abline(v=max(t[resol[,"S"]*R0>=1]), col="darkgreen")
points(max(t[resol[,"S"]*R0>=1]), 1, pch=19)

plot(t,resol[,"S"], type="l", xlab="time", ylab="", col="grey")
lines(t,resol[,"I"], col="red", lwd=3)
lines(t,resol[,"R"], col="light blue")
abline(v=max(t[resol[,"S"]*R0>=1]), col="darkgreen")
points(max(t[resol[,"S"]*R0>=1]), max(resol[,"I"]), pch=19)

# The effective reproductive number is on the left.
# When R_0 reach 1, we actually reach the maximum of the infected.

##### Stability and Periodicity
# When adding mu, obtain another interesting dynamics of the number of infected.
times = seq(0, 100, by=.1)
p = c(mu = 1/100, N = 1, beta = 50, gamma = 10)
start_SIR = c(S=0.19, I=0.01, R = 0.8)
resol = ode(y=start_SIR, t=times, func=SIR, p=p)
par(mfrow=c(1,1))
plot(resol[,"time"], resol[,"I"], type="l", xlab="time", ylab="")

# Represent the three equations in two dimension with Jacobian matrix, let ...
# X = dS/dt = mu*(N-S) - beta*I*S/N
# Y = dI/dt =            beta*I*S/N - (gamma+mu)*I
#
# Then Jacobian of the system
# [[dX/dS, dX/dI],
#   dY/dS, dY/dI]]
# is
# [[-mu-beta*U/N, -beta*S/N],
#  [   -beta*I/N,  beta*S/N-(gamma+mu)]]
#
# Evaluate the Jacobian at the equilibrium
# S* = (gamma+mu)/beta = 1/R_0
# I* = mu*(R_0-1)/beta

mu = 0.01
beta = 50
gamma = 10
S = (gamma + mu)/beta
I = mu * (beta/(gamma + mu) - 1)/beta
J = matrix(c(-(mu+beta*I/N), -beta*S/N,
                  beta*I/N,   beta*S/N-(mu+gamma)), 2, 2, byrow = TRUE)

eigen(J)$values
# [1] -0.024975+0.6318831i -0.024975-0.6318831i

2 * pi/(Im(eigen(J)$values[1])) 
# [1] 9.943588 # damping period of 10 time lengths (10 days or 10 weeks)

# Add the period to the plot
yi = resol[,"I"]
dyi = diff(yi)
i = which((dyi[2:length(dyi)]*dyi[1:(length(dyi)-1)])<0)
t = resol[i,"time"]
arrows(t[2], 0.008, t[4], 0.008, length=0.1, code=3)
