pkgs = c(
  "tidyverse",
  "citr",
  "sf"
)
message("Trying to load these pkgs: ", paste(pkgs, collapse = " "))
installed = pkgs %in% utils::installed.packages()
pkgsn = pkgs[!installed]
if(!all(installed)) {
  message("Trying to install: ", paste(pkgsn, collapse = " "))
  install.packages(pkgsn)
}
vapply(pkgs, require, logical(1), character.only = TRUE)
