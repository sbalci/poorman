#' Create or transform variables
#'
#' `mutate()` adds new variables and preserves existing ones; `transmute()` adds new variables and drops existing ones.
#' Both functions preserve the number of rows of the input. New variables overwrite existing variables of the same name.
#'
#' @param .data A `data.frame`.
#' @param ... Name-value pairs of expressions, each with length `1L`. The name of each argument will be the name of a
#' new column and the value will be its corresponding value. Use a `NULL` value in `mutate` to drop a variable. New
#' variables overwrite existing variables of the same name.
#'
#' @examples
#' mutate(mtcars, mpg2 = mpg * 2)
#' mtcars %>% mutate(mpg2 = mpg * 2)
#' mtcars %>% mutate(mpg2 = mpg * 2, cyl2 = cyl * 2)
#'
#' # Newly created variables are available immediately
#' mtcars %>% mutate(mpg2 = mpg * 2, mpg4 = mpg2 * 2)
#'
#' # You can also use mutate() to remove variables and modify existing variables
#' mtcars %>% mutate(
#'   mpg = NULL,
#'   disp = disp * 0.0163871 # convert to litres
#' )
#'
#' @name mutate
#' @export
mutate <- function(.data, ...) {
  check_is_dataframe(.data)
  UseMethod("mutate")
}

#' @export
mutate.default <- function(.data, ...) {
  conditions <- dotdotdot(..., .impute_names = TRUE)
  .data[, setdiff(names(conditions), names(.data))] <- NA
  context$setup(.data)
  on.exit(context$clean(), add = TRUE)
  for (i in seq_along(conditions)) {
    context$.data[, names(conditions)[i]] <- eval(conditions[[i]], envir = context$.data)
  }
  context$.data
}

#' @export
mutate.grouped_data <- function(.data, ...) {
  rows <- rownames(.data)
  res <- apply_grouped_function("mutate", .data, drop = TRUE, ...)
  res[rows, ]
}
