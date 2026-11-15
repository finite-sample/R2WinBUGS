fake_chains <- function(n = 100, m = 3, names = c("mu", "tau"), shift = 0, seed = 1) {
  set.seed(seed)
  a <- array(rnorm(n * m * length(names)), c(n, m, length(names)))
  a[, , 1] <- a[, , 1] + rep(seq_len(m) * shift, each = n)
  dimnames(a) <- list(NULL, NULL, names)
  a
}
