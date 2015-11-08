myMean <- function() {
  x <- rnorm(100)
  mean(x)
}
addNoise <- function(x) {
  x + rnorm(length(x))
}