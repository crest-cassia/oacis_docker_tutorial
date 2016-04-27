dir.create(Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("DoE.base", Sys.getenv("R_LIBS_USER"), repos = "http://cran.ism.ac.jp" )

