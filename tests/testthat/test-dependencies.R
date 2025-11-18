test_that("GeomRrect and GeomRtile no longer exist", {
  # These custom grid-based geoms should be removed
  expect_false(exists("GeomRrect"))
  expect_false(exists("GeomRtile"))
  expect_false(exists("geom_rrect"))
  expect_false(exists("geom_rtile"))
})

test_that("No RColorBrewer dependency in color generation", {
  # waffle function should not call RColorBrewer::brewer.pal
  waffle_body <- deparse(body(waffle))
  waffle_source <- paste(waffle_body, collapse = " ")

  expect_false(grepl("RColorBrewer", waffle_source))
  expect_false(grepl("brewer.pal", waffle_source))
})

test_that("Hardcoded Set2 colors are used", {
  # Check that waffle function has hardcoded Set2 colors
  waffle_body <- deparse(body(waffle))
  waffle_source <- paste(waffle_body, collapse = " ")

  # Should contain the first Set2 color hex code
  expect_true(grepl("#66C2A5", waffle_source))
})

test_that("plyr dependency removed from StatWaffle", {
  # StatWaffle should use do.call(rbind) instead of plyr::rbind.fill
  stat_setup <- deparse(StatWaffle$setup_data)
  stat_source <- paste(stat_setup, collapse = " ")

  expect_false(grepl("plyr::rbind.fill", stat_source))
  expect_true(grepl("do.call\\(rbind", stat_source))
})

test_that("gtable utility functions removed from utils.r", {
  # rbind_gtable_max and cbind_gtable_max should be removed
  utils_exists <- exists("rbind_gtable_max")
  expect_false(utils_exists)

  utils_exists2 <- exists("cbind_gtable_max")
  expect_false(utils_exists2)

  utils_exists3 <- exists("insert_unit")
  expect_false(utils_exists3)

  # ggname should also be removed
  expect_false(exists("ggname"))
})

test_that("patchwork is imported", {
  # Check DESCRIPTION imports patchwork
  desc_file <- system.file("DESCRIPTION", package = "waffle")
  if (file.exists(desc_file)) {
    desc <- readLines(desc_file)
    desc_text <- paste(desc, collapse = "\n")
    expect_true(grepl("patchwork", desc_text))
  }
})

test_that("gridExtra and gtable not in DESCRIPTION", {
  # These should be removed from dependencies
  desc_file <- system.file("DESCRIPTION", package = "waffle")
  if (file.exists(desc_file)) {
    desc <- readLines(desc_file)
    desc_text <- paste(desc, collapse = "\n")

    # Look for these in Import section specifically
    imports_start <- grep("^Imports:", desc)
    if (length(imports_start) > 0) {
      # Find next section (starts with capital letter at beginning of line)
      next_section <- grep("^[A-Z][a-zA-Z]+:", desc)
      next_section <- next_section[next_section > imports_start][1]

      if (!is.na(next_section)) {
        imports_section <- desc[imports_start:(next_section - 1)]
      } else {
        imports_section <- desc[imports_start:length(desc)]
      }
      imports_text <- paste(imports_section, collapse = " ")

      expect_false(grepl("gridExtra", imports_text))
      expect_false(grepl("gtable", imports_text))
      expect_false(grepl("RColorBrewer", imports_text))
    }
  }
})
