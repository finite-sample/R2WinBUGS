test_that("findUnixBinary finds a program in /usr/bin without a PATH lookup", {
  skip_on_os("windows")
  skip_if_not(file.exists("/usr/bin/env"))
  withr::local_envvar(ENV = "", PATH = "")
  expect_identical(R2WinBUGS:::findUnixBinary("env"), "/usr/bin/env")
})
