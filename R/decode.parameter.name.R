"decode.parameter.name" <-
  function(a) {
    #
    # Decodes Bugs parameter names
    #   (e.g., "beta[3,14]" becomes "beta" with 2 indexes:  3 and 14)
    # for use by the bugs.sim() function
    #
    left.bracket <- regexpr("[[]", a)
    if (left.bracket == -1) {
      root <- a
      dimension <- 0
      indexes <- NA
    } else {
      root <- substring(a, 1, left.bracket - 1)
      right.bracket <- regexpr("[]]", a)
      a <- substring(a, left.bracket + 1, right.bracket - 1)
      indexes <- as.numeric(unlist(strsplit(a, ",")))
      dimension <- length(indexes)
    }
    list(root = root, dimension = dimension, indexes = indexes)
  }

# Order of parameter names that groups each root, in order of first
# appearance, and within a root sorts by the indexes with the last one
# varying fastest: theta[1,1], theta[1,2], theta[2,1], ...
order_bugs_style <- function(parameter.names) {
  decoded <- lapply(parameter.names, decode.parameter.name)
  roots <- vapply(decoded, `[[`, "", "root")
  width <- max(vapply(decoded, `[[`, 0, "dimension"), 1)
  indexes <- matrix(unlist(lapply(decoded, function(d) {
    i <- if (d$dimension == 0) numeric(0) else d$indexes
    c(i, rep(0, width - length(i)))
  })), ncol = width, byrow = TRUE)
  keys <- c(list(match(roots, unique(roots))), lapply(seq_len(width), function(k) indexes[, k]))
  do.call(order, keys)
}
