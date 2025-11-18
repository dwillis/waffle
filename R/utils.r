round_preserve_sum <- function(x, digits = 0) {
  up <- 10^digits
  x <- x * up
  y <- floor(x)
  indices <- tail(order(x - y), round(sum(x)) - sum(y))
  y[indices] <- y[indices] + 1
  y / up
}


is_missing_arg <- function(x) identical(x, quote(expr = ))

"%||%" <- function(a, b) { if (!is.null(a)) a else b }
"%l0%" <- function(a, b) { if (length(a)) a else b }

.pt <- ggplot2::.pt