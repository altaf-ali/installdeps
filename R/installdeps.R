# install all dependencies in the current script

install_dependencies <- function() {
  installed_packages <- row.names(installed.packages())
  doc <- rstudioapi::getActiveDocumentContext()
  for (s in doc$contents) {
    m <- stringr::str_match(s, "library\\((.*)\\)")
    package_name <- stringr::str_trim(m[1,2])
    if (!is.na(package_name)) {
      if (!(package_name %in% installed_packages)) {
        install.packages(package_name)
      }
    }
  }
}
