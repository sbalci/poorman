expect_error(
  mtcars %>% pull(mpg, cyl),
  info = "Expect error when pulling multiple columns"
)

expect_equal(
  mtcars %>% pull(mpg),
  mtcars[, "mpg"],
  info = "Test pulling a single nse column"
)

expect_equal(
  mtcars %>% pull("mpg"),
  mtcars[, "mpg"],
  info = "Test pulling a single quoted column"
)

expect_equal(
  mtcars %>% pull(1L),
  mtcars[, "mpg"],
  info = "Test pulling a single column with an integer"
)

expect_equal(
  mtcars %>% pull(1),
  mtcars[, "mpg"],
  info = "Test pulling a single column with a numeric"
)

expect_equal(
  mtcars %>% pull(-1L),
  mtcars[, "carb"],
  info = "Test pulling a single column with a negative integer"
)

expect_equal(
  mtcars %>% pull(-1),
  mtcars[, "carb"],
  info = "Test pulling a single column with a negative numeric"
)

expect_equal(
  {
    var <- "mpg"
    mtcars %>% pull(var)
  },
  mtcars[, "mpg"],
  info = "Can pull using a variable"
)
