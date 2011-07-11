# ~/.Rprofile # source("/my/config/rprofile.r")

# General options 
options(tab.width = 2)
 
.First <- function(){
  #library(Hmisc)
  #library(R2HTML)
  library(ggplot2)
  cat("\nWelcome at", date(), "\n\n") 
}

.Last <- function(){ 
 cat("\nGoodbye at ", date(), "\n")
}
