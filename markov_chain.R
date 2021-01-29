# install.packages("markovchain")
library(markovchain)
# install.packages("diagram")
library(diagram)

# define a transition probability matrix
tmA <- matrix(c(0.25, 0.65, 0.1, 0.25, 0.25, 0.5, 0.35, 0.25, 0.4),
              nrow = 3, byrow = TRUE)

# create the discrete-time markov chain
dtmcA <- new("markovchain", 
             transitionMatrix = tmA, 
             states = c("No Rain","Light Rain","Heavy Rain"), 
             name = "MarkovChain A") 
dtmcA
# MarkovChain A 
#  A  3 - dimensional discrete Markov Chain defined by the following states: 
#  No Rain, Light Rain, Heavy Rain 
#  The transition matrix  (by rows)  is defined as follows: 
#            No Rain Light Rain Heavy Rain
# No Rain       0.25       0.65        0.1
# Light Rain    0.25       0.25        0.5
# Heavy Rain    0.35       0.25        0.4

# access the probability in the matrix
dtmcA[2,3]
# [1] 0.5
transitionProbability(dtmcA, "Light Rain", "Heavy Rain")
# [1] 0.5

# simulate state distribution after n steps
initialState <- c(0,1,0)
steps <- 2
finalState <- initialState*dtmcA^steps
finalState
#      No Rain Light Rain Heavy Rain
# [1,]     0.3       0.35       0.35

# find probability at steady state
steadyStates(dtmcA)
#        No Rain Light Rain Heavy Rain
# [1,] 0.2850877  0.3640351  0.3508772

# visualize the diagram
plot(dtmcA)
stateNames <- c("No Rain","Light Rain","Heavy Rain")
row.names(tmA) <- stateNames; colnames(tmA) <- stateNames
plotmat(tmA,pos = c(1,2), 
        lwd = 1, 
        box.lwd = 2, 
        cex.txt = 0.8, 
        box.size = 0.1, 
        box.type = "circle", 
        box.prop = 0.5,
        box.col = "light blue",
        arr.length = 0.1,
        arr.width = 0.1,
        self.cex = 0.6,
        self.shifty = -0.01,
        self.shiftx = 0.14,
        main = "Markov Chain")
