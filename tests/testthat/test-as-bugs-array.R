test_that("indexed parameters are reassembled into arrays in BUGS order", {
  set.seed(2)
  n <- 50
  m <- 2
  pars <- c(paste0("theta[", rep(1:3, 2), ",", rep(1:2, each = 3), "]"), "mu")
  a <- array(rnorm(n * m * length(pars)), c(n, m, length(pars)))
  dimnames(a) <- list(NULL, NULL, pars)
  fit <- as.bugs.array(a, DIC = FALSE)

  expect_s3_class(fit, "bugs")
  expect_identical(dim(fit$sims.list$theta), c(100L, 3L, 2L))
  expect_identical(dim(fit$mean$theta), c(3L, 2L))
  pooled <- apply(a, 3, as.vector)
  expect_equal(fit$mean$theta[2, 1], mean(pooled[, "theta[2,1]"]))
  expect_equal(fit$mean$theta[1, 2], mean(pooled[, "theta[1,2]"]))
  expect_equal(fit$summary[pars, "mean"], colMeans(pooled))
})

test_that("summary is monitor() of the same draws", {
  a <- fake_chains(n = 80, names = c("mu", "tau"))
  a[, , "tau"] <- exp(a[, , "tau"])
  fit <- as.bugs.array(a, DIC = FALSE)
  expect_equal(fit$summary, monitor(a, keep.all = TRUE))
})
