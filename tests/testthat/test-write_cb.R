context("Low-level writing and reading to/from clipboard")

test_that("Character vector is correctly written and read", {
  
  skip_on_travis()

  ch <- "ala ma kota"
  write_cb(ch)
  r <- read_cb()
  expect_identical(ch, r)
} )


test_that("Numeric vector is correctly written and read", {
  
  skip_on_travis()

  x <- 1:5
  write_cb(x)
  r <-read_cb()
  expect_identical(as.character(x), r)
} )
