# Markov Chain Basics & Examples

**Definition**: A stochastic process X<sub>1</sub>, X<sub>2</sub>, ... is a Markov process if for any discrete time index n = 1, 2, ... Pr(X<sub>n+1</sub> = x<sub>n+1</sub> | X<sub>n</sub> = x<sub>n</sub>, ... , X<sub>1</sub> = x<sub>1</sub>) = Pr(X<sub>n+1</sub> = x<sub>n+1</sub> | X<sub>n</sub> = x<sub>n</sub>)

In a Markov process, the probability of a random variable X being equal to some value x at time n + 1, given all the x values that came before it in the sequence, is equal to the probability of X being equal to some value x at time n + 1 given just the value of x that came before it. In other words, X at time n + 1 is only dependent on x at time n, not any other value of x. That is, X at time n + 1 is independent of all other x except X at time n.

This code repository covers two examples - weather and epidemic - on how to:
- define a transition probability matrix
- create a discrete-time Markov chain
- access a transition probability from one to the other states
- simulate the state probability after n steps, given an initial state
- find transient states and absorbing state
- find the state probability at steady state
- draw the state transition diagram

In the third case study, the epidemic is modeled and solved with a system of ordinary differential equations as well as with Jacobian matrix. 

For simplicity, this study considers the states of "susceptible", "infected" and "recovered" (SIR). Often times, such model can also be viewed as "susceptible", "exposed", "infected" and "recovered" (SEIR).

In other cases, such as COVID-19, there could also be the states of "hospitalized", "ICU" and "dead". 

One interesting [scientific article](https://doi.org/10.1051/mmnp/2020045) even broke down the states into "infected undetected", "infected detected", "recovered undetected" and "recovered undetected" to find a balance among interventions: testing/tracing/isolating, quarantine/lockdown, and raising ICU capacity.

## Requirement

For the weather and epidemic examples, run the following command on terminal:
```
sudo apt-get install r-cran-igraph
sudo apt-get install r-cran-markovchain
```

Then in R script, call `markovchain` and `diagram` libraries.
```
> library(markovchain)
Package:  markovchain
Version:  0.8.5-4
Date:     2021-01-07
BugReport: https://github.com/spedygiorgio/markovchain/issues

> library(diagram)
Loading required package: shape
```

For the case study on epidemic modeling with system dynamics, install `deSolve` library.

## Results

Weather forecast: [weather.R](https://github.com/ornwipa/markov_chain/blob/master/weather.R), [default transition (state/probability) diagram](https://github.com/ornwipa/markov_chain/blob/master/Figures/weather_diagram1.png), [more beautiful diagram](https://github.com/ornwipa/markov_chain/blob/master/Figures/weather_diagram2.png)

Epidemic simulation (susceptible-infected-recovered, SIR): [epidemic.R](https://github.com/ornwipa/markov_chain/blob/master/epidemic.R)

<img src="https://github.com/ornwipa/markov_chain/blob/master/Figures/SIR_diagram.png" width="303" height="289"> ![](https://github.com/ornwipa/markov_chain/blob/master/Figures/SIR_stateProbOverTime.png)

Solving SIR model with ordinary differential equations, i.e. system dynamics approach: [epi_ode.R](https://github.com/ornwipa/markov_chain/blob/master/epi_ode.R)

## Acknowledgement

More detailed instructions and reading resources for the weather example can be found in [RPubs](https://rpubs.com/JanpuHou/326048).

Markov chain applied to epidemic (Susceptible-Infected-Recovered) models can be found in [R-bloggers](https://www.r-bloggers.com/2015/12/a-discrete-time-markov-chain-dtmc-sir-model-in-r/).

Explanation on modeling the pandemics were previously written in the series of blog post: [part1](https://freakonometrics.hypotheses.org/60482), [part2](https://freakonometrics.hypotheses.org/60543), [part3](https://freakonometrics.hypotheses.org/60514)

Other resources include [R Package: General Solver for Ordinary Differential Equations](https://www.rdocumentation.org/packages/deSolve/versions/1.27.1/topics/ode) and [Visualization with Infectious Disease Models with shinySIR](https://cran.r-project.org/web/packages/shinySIR/vignettes/Vignette.html).
