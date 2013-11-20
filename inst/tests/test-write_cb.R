context("Writing and reading clipboard on Linux")

test_that("Simple character vector is correctly written and read", {
          ch <- "ala ma kota"
          write_cb(ch)
          r <- read_cb()
          expect_identical(ch, r)
} )


test_that("Simple numeric vector is correctly written and read", {
          x <- 1:5
          write_cb(x)
          r <-read_cb()
          expect_identical(as.character(x), r)
} )
