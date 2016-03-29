# install all dependencies in the current script
install_dependencies <- function(check = FALSE) {
  tryCatch({
    doc <- rstudioapi::getActiveDocumentContext()
    installed_packages <- row.names(installed.packages())
    for (s in doc$contents) {
      m <- stringr::str_match(s, "library\\((.*)\\)")
      package_name <- stringr::str_trim(m[1,2])
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

