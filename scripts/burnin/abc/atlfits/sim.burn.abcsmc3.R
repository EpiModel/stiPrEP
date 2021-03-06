
library("methods")
suppressMessages(library("EpiModelHIV"))
suppressMessages(library("doParallel"))
suppressMessages(library("foreach"))
suppressMessages(library("EasyABC"))

f <- function(x) {

  set.seed(x[1])

  suppressMessages(library("EpiModelHIV"))
  sourceDir("source/", verbose = FALSE)

  param <- param_msm(nwstats = st,
                     ai.scale = 1,

                     prep.coverage = 0,
                     prep.start = 1e8,

                     rcomp.prob = 0,
                     rcomp.adh.groups = 0:3,
                     rcomp.main.only = FALSE,
                     rcomp.discl.only = FALSE,

                     rgc.tprob = x[2],
                     ugc.tprob = x[3],
                     rct.tprob = x[4],
                     uct.tprob = x[5],

                     rgc.sympt.prob = x[6],
                     ugc.sympt.prob = x[7],
                     rct.sympt.prob = x[8],
                     uct.sympt.prob = x[9],

                     rgc.dur.asympt = x[10],
                     ugc.dur.asympt = x[11],
                     gc.dur.tx = 2,
                     gc.dur.ntx = NULL,

                     rct.dur.asympt = x[12],
                     uct.dur.asympt = x[13],
                     ct.dur.tx = 2,
                     ct.dur.ntx = NULL,

                     gc.prob.cease = 0,
                     ct.prob.cease = 0,

                     gc.sympt.prob.tx = 0.90,
                     ct.sympt.prob.tx = 0.85,
                     gc.asympt.prob.tx = 0,
                     ct.asympt.prob.tx = 0,

                     prep.sti.screen.int = 182,
                     prep.sti.prob.tx = 1,
                     prep.continue.stand.tx = TRUE,

                     sti.cond.rr = 0.3,

                     hiv.rgc.rr = x[14],
                     hiv.ugc.rr = x[15],
                     hiv.rct.rr = x[14],
                     hiv.uct.rr = x[15],
                     hiv.dual.rr = 0)

  init <- init_msm(nwstats = st,
                   prev.B = 0.253,
                   prev.W = 0.253,
                   prev.ugc = 0.01,
                   prev.rgc = 0.01,
                   prev.uct = 0.01,
                   prev.rct = 0.01)

  control <- control_msm(simno = 1,
                         nsteps = 1000,
                         nsims = 1,
                         ncores = 1,
                         acts.FUN = acts_sti,
                         condoms.FUN = condoms_sti,
                         initialize.FUN = initialize_sti,
                         prep.FUN = prep_sti,
                         prev.FUN = prevalence_sti,
                         riskhist.FUN = riskhist_sti,
                         position.FUN = position_sti,
                         trans.FUN = trans_sti,
                         stitrans.FUN = sti_trans,
                         stirecov.FUN = sti_recov,
                         stitx.FUN = sti_tx,
                         verbose.FUN = verbose_sti,
                         verbose = FALSE,
                         module.order = c("aging.FUN", "deaths.FUN", "births.FUN",
                                          "test.FUN", "tx.FUN", "prep.FUN",
                                          "progress.FUN", "vl.FUN",
                                          "resim_nets.FUN", "disclose.FUN",
                                          "acts.FUN", "condoms.FUN", "riskhist.FUN",
                                          "position.FUN", "trans.FUN", "stitrans.FUN",
                                          "stirecov.FUN", "stitx.FUN", "prev.FUN"))


  data(est)
  sim <- netsim(est, param, init, control)

  df <- tail(as.data.frame(sim), 200)

  rgc.prev <- mean(df$prev.rgc)
  ugc.prev <- mean(df$prev.ugc)
  rct.prev <- mean(df$prev.rct)
  uct.prev <- mean(df$prev.uct)

  rgc.incid <- mean(df$ir100.rgc)
  ugc.incid <- mean(df$ir100.ugc)
  rct.incid <- mean(df$ir100.rct)
  uct.incid <- mean(df$ir100.uct)

  hiv.prev <- mean(df$i.prev)

  out <- c(rgc.prev, ugc.prev, rct.prev, uct.prev,
           rgc.incid, ugc.incid, rct.incid, uct.incid,
           hiv.prev)

  return(out)
}

# rgc.tprob <- runif(n, 0.35, 0.60)
# ugc.tprob <- runif(n, 0.20, 0.40)
# rct.tprob <- runif(n, 0.35, 0.60)
# uct.tprob <- runif(n, 0.20, 0.40)
#
# rgc.sympt.prob <- runif(n, 0.05, 0.20)
# ugc.sympt.prob <- runif(n, 0.60, 0.95)
# rct.sympt.prob <- runif(n, 0.05, 0.20)
# uct.sympt.prob <- runif(n, 0.60, 0.95)
#
# rgc.dur.asympt <- runif(n, 26, 52)
# ugc.dur.asympt <- runif(n, 26, 52)
# rct.dur.asympt <- runif(n, 39, 65)
# uct.dur.asympt <- runif(n, 39, 65)
#
# hiv.rect.rr <- runif(n, 2, 3)
# hiv.ureth.rr <- runif(n, 1, 2)

priors <- list(c("unif", 0.20, 0.60),
               c("unif", 0.15, 0.40),
               c("unif", 0.20, 0.60),
               c("unif", 0.15, 0.40),
               c("unif", 0.01, 0.15),
               c("unif", 0.60, 0.95),
               c("unif", 0.01, 0.15),
               c("unif", 0.60, 0.95),
               c("unif", 26, 52),
               c("unif", 26, 52),
               c("unif", 39, 65),
               c("unif", 39, 65),
               c("unif", 2, 3),
               c("unif", 1, 2))

# rgc.prev, ugc.prev, rct.prev, uct.prev,
# rgc.incid, ugc.incid, rct.incid, uct.incid,
# hiv.prev
# targets <- c(0.083, 0.015, 0.118, 0.027,
#              6.55, 1.20, 8.15, 3.85,
#              0.26)
targets <- c(0.083, 0.015, 0.118, 0.027,
             6.19, 1.07, 7.81, 3.75,
             0.26)

a <- ABC_sequential(method = "Lenormand",
                    model = f,
                    prior = priors,
                    nb_simul = 200,
                    alpha = 0.25,
                    summary_stat_target = targets,
                    p_acc_min = 0.02,
                    dist_weights = c(1, 1, 1, 1, 2, 2, 2, 2, 1),
                    progress_bar = TRUE,
                    n_cluster = 16,
                    use_seed = TRUE,
                    verbose = FALSE)
save(a, file = "data/smc.atl.raceavg.distw.2pct.200sim.rda")

# system("scp scripts/burnin/*.abcsmc3.[Rs]* hyak:/gscratch/csde/sjenness/sti2")
# system("scp source/*.* hyak:/gscratch/csde/sjenness/sti2/source/")
