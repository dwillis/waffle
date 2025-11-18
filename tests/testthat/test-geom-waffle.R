test_that("GeomWaffle inherits from ggplot2::GeomTile", {
  expect_true(inherits(GeomWaffle, "ggproto"))
  expect_equal(GeomWaffle$`_inherit`$`_class`, "GeomTile")
})

test_that("geom_waffle creates a ggplot layer", {
  skip_if_not_installed("ggplot2")

  data <- data.frame(
    parts = c("A", "B", "C"),
    values = c(30, 20, 50)
  )

  p <- ggplot2::ggplot(data, ggplot2::aes(fill = parts, values = values)) +
    geom_waffle(n_rows = 10)

  expect_s3_class(p, "gg")
  expect_s3_class(p, "ggplot")
  expect_equal(length(p$layers), 1)
})

test_that("geom_waffle does not accept radius parameter", {
  skip_if_not_installed("ggplot2")

  # radius parameter should not be in the function signature
  fn_args <- names(formals(geom_waffle))
  expect_false("radius" %in% fn_args)
})

test_that("stat_waffle creates a ggplot layer", {
  skip_if_not_installed("ggplot2")

  data <- data.frame(
    parts = c("A", "B", "C"),
    values = c(30, 20, 50)
  )

  p <- ggplot2::ggplot(data, ggplot2::aes(fill = parts, values = values)) +
    stat_waffle(n_rows = 10)

  expect_s3_class(p, "gg")
  expect_s3_class(p, "ggplot")
})

test_that("stat_waffle does not accept radius parameter", {
  skip_if_not_installed("ggplot2")

  # radius parameter should not be in the function signature
  fn_args <- names(formals(stat_waffle))
  expect_false("radius" %in% fn_args)
})

test_that("StatWaffle does not have radius in extra_params", {
  expect_false("radius" %in% StatWaffle$extra_params)
})

test_that("geom_waffle works with faceting", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("dplyr")

  data <- data.frame(
    parts = factor(rep(c("A", "B", "C"), 3)),
    values = c(10, 20, 30, 6, 14, 40, 30, 20, 10),
    facet = c(rep("F1", 3), rep("F2", 3), rep("F3", 3))
  )

  p <- ggplot2::ggplot(data, ggplot2::aes(fill = parts, values = values)) +
    geom_waffle(n_rows = 5) +
    ggplot2::facet_wrap(~facet)

  expect_s3_class(p, "gg")
  expect_equal(length(p$facet$params$facets), 1)
})

test_that("geom_waffle supports flip parameter", {
  skip_if_not_installed("ggplot2")

  data <- data.frame(
    parts = c("A", "B"),
    values = c(30, 20)
  )

  p1 <- ggplot2::ggplot(data, ggplot2::aes(fill = parts, values = values)) +
    geom_waffle(n_rows = 5, flip = FALSE)

  p2 <- ggplot2::ggplot(data, ggplot2::aes(fill = parts, values = values)) +
    geom_waffle(n_rows = 5, flip = TRUE)

  expect_s3_class(p1, "gg")
  expect_s3_class(p2, "gg")
})

test_that("geom_waffle supports make_proportional parameter", {
  skip_if_not_installed("ggplot2")

  data <- data.frame(
    parts = c("A", "B"),
    values = c(75, 25)
  )

  p <- ggplot2::ggplot(data, ggplot2::aes(fill = parts, values = values)) +
    geom_waffle(n_rows = 10, make_proportional = TRUE)

  expect_s3_class(p, "gg")
})
