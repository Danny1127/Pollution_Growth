#---------------------------------------------------------------------
### read data
#---------------------------------------------------------------------
rm(list=ls())
library(tictoc)
tic()
source("code/Functions/readPM25.R")
source("code/Functions/link_data_less.R")

data_folder <-  "Data/PM25/GlobalGWRc/"  #"Data/PM25/Unified/"
if (length(grep("Unified",data_folder))>0){
  lastyear <- 2014
  save2 <- "RData/GDP_PM25Unified"
}else{
  lastyear <- 2017
  save2 <- "RData/GDP_PM25"
}


### read PM25
PM25 <- readPM25(data_folder)

#---------------------------------------------------------------------
### link data
#---------------------------------------------------------------------
GDP_PM25 <- link_data(PM25,lastyear)

source("code/Functions/link_CSC.R")
GDP_PM25_CSC <- link_CSC(GDP_PM25)

### clean names
names(GDP_PM25_CSC) <- gsub("...","",names(GDP_PM25_CSC),fixed=T)
print(names(GDP_PM25_CSC))
save(GDP_PM25_CSC,file= paste0(save2,".RData"))

### for Orange 
write.csv(GDP_PM25_CSC,file=paste0(save2,".csv"),row.names = F)

library(foreign)
write.dta(GDP_PM25_CSC, paste0(save2,".dta") )
cat("GDP_PM25_CSC ready in RData/. Total time: ")
toc()


