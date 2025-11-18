# waffle 2.0.0

## Major Changes

This is a major rewrite of the waffle package to use only ggplot2 for rendering, removing custom grid graphics geoms.

### Breaking Changes

* **Rounded corners removed**: Waffle tiles now have square corners instead of rounded corners. The `radius` parameter has been removed from `geom_waffle()` and `stat_waffle()`.

* **Dependencies changed**:
  - Added `patchwork` for plot composition
  - Removed `RColorBrewer`, `gridExtra`, `gtable`, and `plyr` dependencies
  - Minimal grid dependency retained only for pictogram legend rendering

### Improvements

* **Simplified codebase**: Removed custom geoms (`GeomRrect`, `GeomRtile`) in favor of native ggplot2 `GeomTile`
* **Modern plot composition**: The `iron()` function now uses `patchwork` for combining plots
* **Reduced dependencies**: Fewer package dependencies make installation faster and reduce potential conflicts
* **Maintainability**: Pure ggplot2 implementation is easier to maintain and extend

### Implementation Details

* `GeomWaffle` now inherits directly from `ggplot2::GeomTile` instead of custom grid-based geoms
* Default color palette (Set2) is now hardcoded instead of using RColorBrewer
* `iron()` function uses patchwork's `/` operator for vertical stacking
* Replaced `plyr::rbind.fill()` with base R `do.call(rbind, ...)` in stat transformations

### Compatibility

* All core waffle chart functionality remains the same
* `geom_waffle()`, `stat_waffle()`, `geom_pictogram()` work as before (except for rounded corners)
* Font Awesome integration unchanged
* Examples and vignettes work with minimal changes

---

# waffle 1.0.2

Previous stable version with rounded corners and grid-based geoms.
