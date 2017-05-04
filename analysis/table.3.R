
## STI PrEP Table 3: HIV outcomes


rm(list = ls())
library("EpiModelHIV")
library("EpiModelHPC")
library("dplyr")
source("analysis/fx.R")


load("data/sim.n100.rda")
sim.base <- sim
epi_stats(sim.base, at = 520, qnt.low = 0.25, qnt.high = 0.75)

# Varying PrEP coverage 20%, 40%, 60%, 80%: 1037, 1039, 1041, 1043
load("data/sim.n1043.rda")
sim$param$prep.coverage
sim$param$rcomp.prob
epi_stats(sim.base, sim, at = 520, qnt.low = 0.25, qnt.high = 0.75)


# Vary risk compensation 0%, 20%, 40%, 60%, 80%, 100%: 1003, 1021, 1039, 1057, 1075, 1093
load("data/sim.n1093.rda")
sim$param$prep.coverage
sim$param$rcomp.prob
epi_stats(sim.base, sim, at = 520, qnt.low = 0.25, qnt.high = 0.75)

# Vary STI testing interval 3, 6, 12 months: 2001, 1039, 2004
load("data/sim.n2004.rda")
sim$param$prep.coverage
sim$param$rcomp.prob
round(sim$param$prep.sti.screen.int * (12/52), 0)
epi_stats(sim.base, sim, at = 520, qnt.low = 0.25, qnt.high = 0.75)


