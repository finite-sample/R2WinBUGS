# R2WinBUGS

[![CRAN status](https://www.r-pkg.org/badges/version/R2WinBUGS)](https://CRAN.R-project.org/package=R2WinBUGS)
[![R-CMD-check](https://github.com/finite-sample/R2WinBUGS/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/finite-sample/R2WinBUGS/actions/workflows/R-CMD-check.yml)

R2WinBUGS runs a WinBUGS (or OpenBUGS) model from R. You write the model in
the BUGS language, pass data and initial values from R, and get back the
simulations as R arrays, with a summary table of each parameter's posterior
mean, quantiles, and the convergence statistics `Rhat` and effective sample
size, plus plots of both. The `bugs` class and its helpers (`monitor()`,
`as.bugs.array()`, `write.model()`) also work with output from other MCMC
programs, such as JAGS.

For OpenBUGS on its own, see
[R2OpenBUGS](https://github.com/finite-sample/R2OpenBUGS).

## Installation

WinBUGS 1.4 must be installed separately. It is a Windows program; on Linux
and macOS it can run under WINE (see the
`useWINE` argument of `bugs()`). WinBUGS is available from the
[MRC Biostatistics Unit](https://www.medschl.cam.ac.uk/institutions/mrc-bsu/software-mrc-biostatistics-unit).

```r
# Released version
install.packages("R2WinBUGS")

# Development version
# install.packages("pak")
pak::pak("finite-sample/R2WinBUGS")
```

## Example

The eight-schools model (Gelman et al., *Bayesian Data Analysis*): the
estimated effect of coaching on SAT scores in eight schools, each with its
standard error, pooled through a hierarchical normal model.

```r
library(R2WinBUGS)

model_file <- system.file("model", "schools.txt", package = "R2WinBUGS")
data(schools)

J <- nrow(schools)
data <- list(J = J, y = schools$estimate, sigma.y = schools$sd)

inits <- function() {
  list(theta = rnorm(J, 0, 100), mu.theta = rnorm(1, 0, 100),
       sigma.theta = runif(1, 0, 100))
}

fit <- bugs(
  data = data,
  inits = inits,
  parameters.to.save = c("theta", "mu.theta", "sigma.theta"),
  model.file = model_file,
  n.chains = 3,
  n.iter = 5000,
  bugs.directory = "c:/Program Files/WinBUGS14/"
)
print(fit)
plot(fit)
```

## Citation

Sturtz, S., Ligges, U., and Gelman, A. (2005). R2WinBUGS: A Package for
Running WinBUGS from R. *Journal of Statistical Software*, 12(3), 1–16.
[doi:10.18637/jss.v012.i03](https://doi.org/10.18637/jss.v012.i03)

## License

GPL-2.
