# Markov Chain Basics & Examples

**Definition**: A stochastic process X1,X2,..., is a Markov process if for any discrete time index n=1,2,...; Pr(Xn+1=xn+1|Xn=xn,...,X1=x1) = Pr(Xn+1=xn+1|Xn=xn)

In Markov chain, the probability of a random variable X being equal to some value x at time n + 1, given all the x values that came before it in the sequence, is equal to the probability of X being equal to some value x at time n + 1 given just the value of x that came before it. In other words, X at time n + 1 is only dependent on x at time n, not any other value of x. That is, X at time n + 1 is independent of all other x except X at time n.

This example covers:
- defining a transition probability matrix
- creating a discrete-time Markov chain
- accessing a transition probability from one state to another 
- simulating the state probability after n steps
- finding the state probability at steady state
- drawing the state transition diagram

## Requirement

Prior to use the R packages, run the following command on terminal:
```
sudo apt-get install r-cran-igraph
sudo apt-get install r-cran-markovchain
```

In RStudio, install and call the packages:
```
> install.packages("markovchain")
> library(markovchain)
Package:  markovchain
Version:  0.8.5-4
Date:     2021-01-07
BugReport: https://github.com/spedygiorgio/markovchain/issues

> install.packages("diagram")
> library(diagram)
Loading required package: shape
```

## Acknowledgement

More detailed instructions and reading resources for the weather example can be found in [RPubs](https://rpubs.com/JanpuHou/326048).

Markov chain applied to Susceptible-Infected-Recovered model in epidemic can be found in [R-bloggers](https://www.r-bloggers.com/2015/12/a-discrete-time-markov-chain-dtmc-sir-model-in-r/)
