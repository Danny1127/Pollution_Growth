### link CSC to GDP_PM25
link_CSC <- function(GDP_PM25){
  library(dplyr)
  source("code/Functions/readCSC.R")
  
  CSC <- readCSC()
  
  load("RData/GDP_PM25.RData")
  
  GDP_PM25_CSC <- left_join(GDP_PM25,CSC,by=c("Country.Code","Year"="time"),suffix=c("","_CSC"))
  
  ### check matching result
  print(with(GDP_PM25_CSC,table(is.na(Country.Name),Year)))
  GDP_PM25_CSC$Country.Name <- NULL
  
  detach("package:dplyr",unload=T)
  return(GDP_PM25_CSC)
}