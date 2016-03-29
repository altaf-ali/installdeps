# check all dependencies in the current script
check_dependencies <- function() {
  tryCatch({
    doc <- rstudioapi::getActiveDocumentContext()
    installed_packages <- row.names(installed.packages())
    for (s in doc$contents) {
      m <- stringr::str_match(s, "library\\((.*)\\)")
      package_name <- stringr::str_trim(m[1,2])
      if (is.na(package_name) || (package_name %in% installed_packages))
        next
      message(sprintf("Required package '%s' is missing", package_name))
    }
  }, error = function(e) {
    # need error handling or a better message?
    # message(e)
  })
}

# install all dependencies in the current script
install_dependencies <- function() {
  tryCatch({
    doc <- rstudioapi::getActiveDocumentContext()
    installed_packages <- row.names(installed.packages())
    for (s in doc$contents) {
      m <- stringr::str_match(s, "library\\((.*)\\)")
      package_name <- stringr::str_trim(m[1,2])
      if (is.na(package_name) || (package_name %in% installed_packages))
        next
      message(sprintf("Installing package '%s'", package_name))
      install.packages(package_name)
    }
  }, error = function(e) {
    # need error handling or a better message?
    # message(e)
  })
}




