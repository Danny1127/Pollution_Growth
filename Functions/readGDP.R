### read GDP for countries
readGDP <- function(firstyear=1998,lastyear=2018){
  ### set last year to 2015 for unified data
  library(reshape)
  
  GDP <- read.csv(file="Data/GDP/GDP.csv",fileEncoding="UTF-8-BOM")
  GDP$Indicator.Code<-NULL
  GDP$Indicator.Name<-NULL
  
  ### reshape
  GDP1 <- reshape(GDP,direction="long",idvar="Country.Name",varying=paste0("X",1960:2017),v.names = "GDP")
  GDP1$Year <- GDP1$time + 1960 - 1 
  GDP1$time <- NULL
  
  GDP <- subset(GDP1,Year>=firstyear & Year<=lastyear)
  
  row.names(GDP) <- NULL
  
  detach("package:reshape",unload=T)
  return(GDP)
  
}
