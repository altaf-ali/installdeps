# install all dependencies in the current script
install_dependencies <- function(check = FALSE) {
  tryCatch({
    doc <- rstudioapi::getActiveDocumentContext()
    installed_packages <- row.names(installed.packages())
    for (s in doc$contents) {
      m <- stringr::str_match(s, "^\\s*?(library|require)\\((.*)\\)\\s*$")
      package_name <- stringr::str_trim(m[1,3])
      if (is.na(package_name) || (package_name %in% installed_packages))
        next

      if (check)
        msg <- sprintf("Required package '%s' is missing", package_name)
      else
        msg <- sprintf("Installing package '%s'", package_name)

      message(msg)

      if (!check)
        install.packages(package_name)
    }
  }, error = function(e) {
    # need error handling or a better message?
    # message(e)
  })
}

# check all dependencies in the current script
check_dependencies <- function() { install_dependencies(check = TRUE) }

# format_code
format_code <- function() {
  #s = "  > go.wish <- function(reps, Sig, df){"

  tryCatch({
    doc <- rstudioapi::getActiveDocumentContext()
    row <- 1
    for (s in doc$contents) {
      pattern <- "^(\\s*[>\\+]).*"
      if (grepl(pattern, s)) {
        m <- stringr::str_match(s, pattern)
        column <- 1
        target_length <- nchar(m[2])

        start <- rstudioapi::document_position(row, column)
        end <- rstudioapi::document_position(row, column + target_length)

        replacement_text <- paste0(rep(' ', target_length), collapse = '')
        message("Modifying row ", row, " col ", column)
        rstudioapi::modifyRange(rstudioapi::document_range(start, end), replacement_text)
      }

      row <- row + 1
    }
  }, error = function(e) {
    # need error handling or a better message?
    message(e)
  })
}
