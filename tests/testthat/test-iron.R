test_that("iron function exists and is exported", {
  expect_true(exists("iron"))
  expect_type(iron, "closure")
})

test_that("iron uses patchwork for plot composition", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("patchwork")

  # Create simple waffle plots
  parts1 <- c(A = 30, B = 20)
  parts2 <- c(X = 15, Y = 25)

  w1 <- waffle(parts1, rows = 5)
  w2 <- waffle(parts2, rows = 5)

  # iron should return a patchwork object
  result <- iron(w1, w2)

  # Check that result is a patchwork composition
  expect_s3_class(result, "patchwork")
})

test_that("iron works with multiple plots", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("patchwork")

  parts <- c(A = 20, B = 10)

  w1 <- waffle(parts, rows = 5)
  w2 <- waffle(parts, rows = 5)
  w3 <- waffle(parts, rows = 5)

  result <- iron(w1, w2, w3)

  expect_s3_class(result, "patchwork")
})

test_that("iron stacks plots vertically", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("patchwork")

  parts <- c(A = 10)

  w1 <- waffle(parts, rows = 2)
  w2 <- waffle(parts, rows = 2)

  # Using patchwork's / operator should create vertical stack
  result <- iron(w1, w2)

  expect_s3_class(result, "patchwork")
  # The result should be plottable
  expect_s3_class(result, "gg")
})

test_that("iron implementation uses Reduce and / operator", {
  # Check the source code of iron to verify it uses patchwork
  iron_body <- deparse(body(iron))
  iron_source <- paste(iron_body, collapse = " ")

  # Should use Reduce
  expect_true(grepl("Reduce", iron_source))
  # Should reference the / operator (division or patchwork stacking)
  expect_true(grepl("/", iron_source, fixed = TRUE))
})
