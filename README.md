# Markov Chain Basics & Examples

**Definition**: A stochastic process X<sub>1</sub>, X<sub>2</sub>, ... is a Markov process if for any discrete time index n = 1, 2, ... Pr(X<sub>n+1</sub> = x<sub>n+1</sub> | X<sub>n</sub> = x<sub>n</sub>, ... , X<sub>1</sub> = x<sub>1</sub>) = Pr(X<sub>n+1</sub> = x<sub>n+1</sub> | X<sub>n</sub> = x<sub>n</sub>)

In a Markov process, the probability of a random variable X being equal to some value x at time n + 1, given all the x values that came before it in the sequence, is equal to the probability of X being equal to some value x at time n + 1 given just the value of x that came before it. In other words, X at time n + 1 is only dependent on x at time n, not any other value of x. That is, X at time n + 1 is independent of all other x except X at time n.

This code repository covers two examples on how to:
- define a transition probability matrix
- create a discrete-time Markov chain
- access a transition probability from one to the other states
- simulate the state probability after n steps, given an initial state
- find transient states and absorbing state
- find the state probability at steady state
- draw the state transition diagram

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

## Results

Weather forecast: [weather.R](https://github.com/ornwipa/markov_chain/blob/master/weather.R), [default transition (state/probability) diagram](https://github.com/ornwipa/markov_chain/blob/master/Figures/weather_diagram1.png), [more beautiful diagram](https://github.com/ornwipa/markov_chain/blob/master/Figures/weather_diagram2.png)

Epidemic simulation (susceptible-infected-recovered): [epidemic.R](https://github.com/ornwipa/markov_chain/blob/master/epidemic.R)

![](https://github.com/ornwipa/markov_chain/blob/master/Figures/SIR_diagram.png) ![](https://github.com/ornwipa/markov_chain/blob/master/Figures/SIR_stateProbOverTime.png)

## Acknowledgement

More detailed instructions and reading resources for the weather example can be found in [RPubs](https://rpubs.com/JanpuHou/326048).

Markov chain applied to epidemic (Susceptible-Infected-Recovered) models can be found in [R-bloggers](https://www.r-bloggers.com/2015/12/a-discrete-time-markov-chain-dtmc-sir-model-in-r/).
