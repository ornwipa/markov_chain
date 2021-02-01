##### Create a Markov chain model
library(markovchain)

# Imagine there are a 10% infection rate and a 20% recovery rate. This implies 90% of Susceptible
# people will remain in the Susceptible state, and 80% of those who are Infected will move to the 
# Recovered state between successive time steps. 100% of those Recovered will stay recovered. 
# None of the people who are Recovered will become Susceptible.
mcSIR <- new("markovchain", states = c("S", "I", "R"),
             transitionMatrix = matrix(data = c(0.9, 0.1, 0,
                                                0, 0.8, 0.2,
                                                0, 0, 1),
                                       byrow = TRUE, nrow = 3),
             name = "SIR")

# Start with a population of 100 people, and only 1 is infected. That means the initial state has
# 99 people that are Susceptible, 1 that is Infected, and 0 are Recovered.
initialState <- c(99, 0, 1)

show(mcSIR)
plot(mcSIR, package = "diagram")

##### Conduct a simulation
# Simulate how many people are in each of the 3 states as moving in discrete time steps to others
timesteps <- 100

# Set up a data frame to contain labels for each time step, and a count of how many people are in
# each state at each time step. 
sir.df <- data.frame(
  #"timestep" = integer(), "S" = numeric(), "I" = numeric(), "R" = numeric(), stringAsFactors = FALSE
  matrix(ncol = 4, nrow = 0))
colnames(sir.df) <- c("timestep", "S", "I", "R")

# Fill that data frame with the results after each time step i, calculated by initialState*mcSIR^i:
for (i in 0:timesteps) {
  newrow <- as.list(c(i, round(as.numeric(initialState*mcSIR^i), 0)))
  sir.df[nrow(sir.df)+1, ] <- newrow
}

# Plot the simulation result
plot(sir.df$timestep, sir.df$S, type = "l", col = "rosybrown",
     main = "DTMC SIR Model", xlab = "time step", ylab = "state probablity as percentage")
lines(sir.df$timestep, sir.df$I, col = "slateblue", lty = 2)
lines(sir.df$timestep, sir.df$R, col = "orangered", lty = 3)
legend(60, 90, legend = c("Susceptible", "Infected", "Recovered"),
       col = c("rosybrown", "slateblue", "orangered"), lty = 1:3, cex = 0.8,
       title = "State", text.font = 4)

##### Use the "markovchain" package to identify elements in the system as it evolves over time
absorbingStates(mcSIR)
# [1] "R"

transientStates(mcSIR)
# [1] "S" "I"

steadyStates(mcSIR)
#      S I R
# [1,] 0 0 1
