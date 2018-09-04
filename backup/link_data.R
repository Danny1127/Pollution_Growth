### full code for linking data
link_date <- function(PM25,lastyear=2018){
  library(dplyr)
  library(tidyr)
  
  source("code/Functions/readGDP.R")
  source("code/Functions/readCPos.R")
  
  GDP <- readGDP(lastyear = lastyear)
  
  
  GDPall <- unique(GDP$Country.Name)
  PMall <- unique(PM25$Country)
  Cposall <- unique(Cpos$name)
  
  d1 <- setdiff(GDPall,Cposall)
  d2 <- setdiff(Cposall,GDPall)
  
  d3 <- setdiff(PMall,Cposall)
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
  
  for (y in c(d3,d1)){
    z<-Cposall[grep(y,Cposall)]
    a <- "Cpos$name"
    if (length(z)==1){
      cat(paste0( a," <- unlist(lapply(",a,',function(x){ifelse("',z,'"== as.character(x),"',y,'",as.character(x)) }))','\n'))
    }
  }
  
  
  
  PM25 <- separate(PM25,"Country",c("Country"),sep=";|[(]",fixed=T,drop=T)
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
  matched <- right_join(PM25,GDP,by=c("Country"="Country.Name","Year"="Year"))
  
  
  nofound <- subset(comb,is.na(Filled))
  found <- subset(comb,Filled==1)
  unmatched <- subset(matched,is.na(PM_Filled))
  PMlist <- unique(nofound$Country)
  GDPlist <- unique(unmatched$Country)
  
  length(unique(nofound$Country))
  length(unique(found$Country))
  
  
  a<- subset(PM25,Country %in% nofound$Country)
  table(a$Country)
  
  comb$highGDP <- ifelse(comb$GDP>1e5,1,0)
  comb$GDP_seg <- factor(ifelse(comb$GDP<=0.5e4,0,ifelse(comb$GDP<=1e4,1,ifelse(comb$GDP<2e4,2,ifelse(comb$GDP<1e5,3,4)))))
  lfit<-lm(GDP~PopWeight_ugm3*highGDP,data=comb)
  lfit<-lm(GDP~PopWeight_ugm3*GDP_seg,data=comb)
  summary(lfit)
  
  
  ### save matched
  GDP_PM25 <- comb
  GDP_PM25$Filled <- NULL
  GDP_PM25$PM_Filled <- NULL
  
  detach("package:dplyr",unload = T)
  detach("package:tidyr",unload = T)
  
  return(GDP_PM25)
  
}
