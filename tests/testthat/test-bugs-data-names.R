test_that("bugs.data writes the same file from names or from a named list", {
  dir <- withr::local_tempdir()
  J <- 3
  y <- c(1.5, -2, 30000)
  sigma <- matrix(1:6, 2, 3)
  f_names <- bugs.data(c("J", "y", "sigma"), dir = dir, data.file = "a.txt")
  f_list <- bugs.data(list(J = J, y = y, sigma = sigma), dir = dir, data.file = "b.txt")
  expect_identical(readLines(file.path(dir, f_names)), readLines(file.path(dir, f_list)))
})
