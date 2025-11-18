test_that("waffle function creates a ggplot object", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 30, B = 20, C = 10)
  p <- waffle(parts, rows = 5)

  expect_s3_class(p, "gg")
  expect_s3_class(p, "ggplot")
})

test_that("waffle function uses Set2 colors by default", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 10, B = 20, C = 15)
  p <- waffle(parts, rows = 5)

  # Check that the plot has a fill scale
  expect_s3_class(p, "gg")

  # Get the fill colors from the plot
  built <- ggplot2::ggplot_build(p)
  colors <- unique(built$data[[1]]$fill)

  # First three Set2 colors (hardcoded in waffle.R)
  set2_colors <- c("#66C2A5", "#FC8D62", "#8DA0CB")

  # Check that our colors match Set2
  expect_true(all(colors %in% set2_colors))
})

test_that("waffle function accepts custom colors", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 10, B = 20)
  custom_colors <- c("red", "blue")

  p <- waffle(parts, rows = 5, colors = custom_colors)

  expect_s3_class(p, "gg")

  # Verify custom colors are used
  built <- ggplot2::ggplot_build(p)
  colors <- unique(built$data[[1]]$fill)

  expect_true("red" %in% colors || "#FF0000" %in% colors)
  expect_true("blue" %in% colors || "#0000FF" %in% colors)
})

test_that("waffle function respects rows parameter", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 40, B = 60)
  p <- waffle(parts, rows = 10)

  expect_s3_class(p, "gg")

  # Check the plot data
  built <- ggplot2::ggplot_build(p)
  data <- built$data[[1]]

  # With 100 total squares and 10 rows, should have tiles
  expect_true(nrow(data) > 0)
})

test_that("waffle function handles named vectors", {
  skip_if_not_installed("ggplot2")

  parts <- c(Dogs = 25, Cats = 15, Birds = 10)
  p <- waffle(parts)

  expect_s3_class(p, "gg")
})

test_that("waffle function handles single value", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 50)
  p <- waffle(parts, rows = 10)

  expect_s3_class(p, "gg")
})

test_that("waffle function works with reverse parameter", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 20, B = 30)

  p1 <- waffle(parts, rows = 5, reverse = FALSE)
  p2 <- waffle(parts, rows = 5, reverse = TRUE)

  expect_s3_class(p1, "gg")
  expect_s3_class(p2, "gg")
})

test_that("waffle function works with pad parameter", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 25, B = 15)

  p <- waffle(parts, rows = 5, pad = 10)

  expect_s3_class(p, "gg")
})

test_that("waffle function works with equal parameter", {
  skip_if_not_installed("ggplot2")

  parts <- c(A = 30, B = 20)

  p1 <- waffle(parts, rows = 5, equal = TRUE)
  p2 <- waffle(parts, rows = 5, equal = FALSE)

  expect_s3_class(p1, "gg")
  expect_s3_class(p2, "gg")
})
