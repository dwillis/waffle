# Waffle Package Tests

This directory contains tests for the waffle package v2.0.0 rewrite.

## Test Coverage

### Core Functionality Tests

**test-geom-waffle.R**
- Verifies `GeomWaffle` inherits from `ggplot2::GeomTile` (not custom grid geoms)
- Tests that `radius` parameter has been removed
- Validates basic waffle chart creation
- Tests faceting support
- Tests flip and make_proportional parameters

**test-waffle-function.R**
- Tests the main `waffle()` function
- Verifies default Set2 color palette (hardcoded, no RColorBrewer)
- Tests custom color support
- Tests various parameters (rows, reverse, pad, equal)
- Validates single and multiple category support

**test-iron.R**
- Verifies `iron()` function uses patchwork for plot composition
- Tests vertical stacking of multiple waffle plots
- Confirms implementation uses `Reduce()` and `/` operator

**test-pictogram.R**
- Verifies `GeomPictogram` inherits from `GeomText`
- Tests pictogram creation
- Validates Font Awesome integration is preserved
- Confirms minimal grid usage (only for legend keys)

**test-dependencies.R**
- Confirms removed dependencies: `GeomRrect`, `GeomRtile`, `RColorBrewer`, `plyr`, `gridExtra`, `gtable`
- Verifies patchwork is added
- Tests that hardcoded colors replace RColorBrewer
- Validates `do.call(rbind)` replaces `plyr::rbind.fill`

## Running Tests

### From R

```r
# Install test dependencies
install.packages("testthat")

# Load the package
devtools::load_all()

# Run all tests
devtools::test()

# Or use testthat directly
testthat::test_dir("tests/testthat")
```

### From Command Line

```bash
# Run R CMD check (includes tests)
R CMD check .

# Or use Rscript
Rscript -e "devtools::test()"
```

## Test Requirements

- R >= 3.5.0
- ggplot2 >= 3.1.0
- patchwork
- testthat >= 3.0.0

## Breaking Changes Tested

1. ✅ Rounded corners removed (`radius` parameter)
2. ✅ `GeomWaffle` now uses `ggplot2::GeomTile`
3. ✅ `iron()` uses patchwork instead of gtable
4. ✅ RColorBrewer dependency removed
5. ✅ plyr dependency removed
6. ✅ gridExtra and gtable removed

## Expected Results

All tests should pass for v2.0.0. Any failures indicate issues with the ggplot2-only rewrite.
