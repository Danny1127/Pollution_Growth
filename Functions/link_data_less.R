### link data with less check
link_data <- function(PM25,lastyear=2018){
  library(dplyr)
  library(tidyr)
  
  source("code/Functions/readGDP.R")
  source("code/Functions/readCPos.R")
  
  GDP <- readGDP(lastyear = lastyear)
  
  GDPall <- unique(GDP$Country.Name)
  PMall <- unique(PM25$Country)
  Cposall <- unique(Cpos$name)
  
  d2 <- setdiff(Cposall,GDPall)
  d4 <- setdiff(Cposall,PMall)
  
  for (y in d4){
    z<-PMall[grep(y,PMall)]
    a <- "PM25$Country"
    if (length(z)==1){
      #cat(paste0( a," <- unlist(lapply(",a,',function(x){ifelse("',z,'"== as.character(x),"',y,'",as.character(x)) }))','\n'))
      PM25$Country <- unlist(lapply(PM25$Country,function(x){ifelse(z== as.character(x),y,as.character(x)) }))
    }
  }
  for (y in d2){
    z<-GDPall[grep(y,GDPall)]
    a <- "GDP$Country.Name"
    if (length(z)==1){
      #cat(paste0( a," <- unlist(lapply(",a,',function(x){ifelse("',z,'"== as.character(x),"',y,'",as.character(x)) }))','\n'))
      GDP$Country.Name <- unlist(lapply(GDP$Country.Name,function(x){ifelse(z== as.character(x),y,as.character(x)) }))
    }
  }
  
  PM25 <- separate(PM25,"Country",c("Country"),sep=";|[(]",fill="right",extra="drop")
  PM25$Country <- trimws(PM25$Country, which = c("right"))
  GDP$Country.Name <- trimws(GDP$Country.Name,which="right")
  
  ### record the start/end of the period
  PM25$Start <- unlist(lapply(PM25$Period,function(x) as.numeric(substr(x,1,4))))
  PM25$End <- unlist(lapply(PM25$Period,function(x) as.numeric(substr(x,8,11))))
  GDP$Filled <- 1
  PM25$PM_Filled <- 1
  
  ### use the middle year to match GDP
  PM25$Year <- PM25$Start+1
  comb <- left_join(PM25,GDP,by=c("Country"="Country.Name","Year"="Year"))
  
  nofound <- subset(comb,is.na(Filled))
  cat("number of countries missing GDP: ",length(unique(nofound$Country)),"\n")
  
  ### save matched
  GDP_PM25 <- comb
  GDP_PM25$Filled <- NULL
  GDP_PM25$PM_Filled <- NULL
  
  detach("package:dplyr",unload = T)
  detach("package:tidyr",unload = T)
  
  return(GDP_PM25)
}