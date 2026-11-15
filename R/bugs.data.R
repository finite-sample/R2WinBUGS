"bugs.data" <-
  function(data, dir = getwd(), digits = 5, data.file = "data.txt", envir = parent.frame()) {
    if (is.numeric(unlist(data))) {
      if (is.R()) {
        write.datafile(
          lapply(data, formatC, digits = digits, format = "E"),
          file.path(dir, data.file)
        )
      } else {
        writeDatafileS4(data, towhere = data.file)
      }
    } else {
      if (is.R()) {
        data.list <- lapply(as.list(data), get, envir = envir)
        names(data.list) <- as.list(data)
        write.datafile(
          lapply(data.list, formatC, digits = digits, format = "E"),
          file.path(dir, data.file)
        )
      } else {
        data.list <- lapply(as.list(data), get, where = parent.frame(2))
        names(data.list) <- unlist(data)
        writeDatafileS4(data.list, towhere = data.file)
      }
    }
    data.file
  }


## S-PLUS is no longer supported (is.R() is always TRUE), so the S-PLUS
## implementations of these were removed; the stubs keep codetools quiet
## about the remaining unreachable S-PLUS branches that call them.
toSingleS4 <- function(...) {
  stop("This function is not intended to be called in R!")
}
"writeDatafileS4" <- toSingleS4
