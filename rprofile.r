# ~/.Rprofile

# load all my .r files
load.my.r <- function () {
  oldpwd <- getwd()    # save current working dir
  setwd("/my/proj/r/") # go to my r file folder
  for (file in dir()) {# load each .r found
    if (substr(file, nchar(file)-1, nchar(file)+1) %in% c(".r", ".R"))
      source(file)
  }
  setwd(oldpwd)        # restore working dir
}

# General options 
options(tab.width = 2)
 
.First <- function(){
  library(ggplot2)
  cat("\nWelcome at", date(), "\n")
  cat("\ndon't forget to load.my.r()\n")
}

.Last <- function(){ 
 cat("\nGoodbye at ", date(), "\n")
}
