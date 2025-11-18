test_that("GeomPictogram exists and inherits from GeomText", {
  expect_true(inherits(GeomPictogram, "ggproto"))
  expect_equal(GeomPictogram$`_inherit`$`_class`, "GeomText")
})

test_that("geom_pictogram creates a ggplot layer", {
  skip_if_not_installed("ggplot2")

  data <- data.frame(
    label = c("star", "heart", "circle"),
    values = c(30, 20, 50)
  )

  p <- ggplot2::ggplot(data, ggplot2::aes(label = label, values = values)) +
    geom_pictogram(n_rows = 10)

  expect_s3_class(p, "gg")
  expect_s3_class(p, "ggplot")
})

test_that("draw_key_pictogram function exists", {
  expect_true(exists("draw_key_pictogram"))
  expect_type(draw_key_pictogram, "closure")
})

test_that("draw_key_pictogram uses grid functions", {
  # This is one of the few places grid is still needed
  key_body <- deparse(body(draw_key_pictogram))
  key_source <- paste(key_body, collapse = " ")

  expect_true(grepl("grid::textGrob", key_source))
  expect_true(grepl("grid::gpar", key_source))
})

test_that("geom_pictogram does not use rounded rectangles", {
  # Pictogram should use text, not rounded rectangles
  geom_pic_draw_panel <- deparse(GeomPictogram$draw_panel)
  geom_pic_source <- paste(geom_pic_draw_panel, collapse = " ")

  expect_false(grepl("roundrectGrob", geom_pic_source))
  expect_false(grepl("grobTree", geom_pic_source))

  # Should delegate to GeomText
  expect_true(grepl("GeomText", geom_pic_source))
})

test_that("scale_label_pictogram exists", {
  expect_true(exists("scale_label_pictogram"))
  expect_type(scale_label_pictogram, "closure")
})

test_that("Font Awesome functions exist", {
  expect_true(exists("fa5_solid"))
  expect_true(exists("fa5_brand"))
  expect_true(exists("fa_list"))
  expect_true(exists("fa_grep"))
})
