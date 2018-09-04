### read country statistics capacity
readCSC <- function(){
  
  CSC <- read.csv("Data/Data_Extract_From_Statistical_Capacity_Indicators/data.csv",fileEncoding="UTF-8-BOM")
  ### delete last five lines
  
  CSC <- subset(CSC,!Country.Code=="")

  library(reshape)
  
  ### rename year
  names(CSC) <- gsub(pattern = "..YR.*","",names(CSC))
  CSC1 <- reshape(CSC,direction="long",idvar="Country.Name",varying=paste0("X",2004:2017),
                  v.names = "CSC",new.row.names = 1:(nrow(CSC)*(2017-2004+1)),times=2004:2017)
  CSC1$Series.Code <- NULL
  CSC1$Series.Name <- droplevels(CSC1$Series.Name)
  CSC1 <- subset(CSC1,!CSC=="..")
  
  CSC2 <- reshape(CSC1,direction="wide",idvar = c("Country.Name","Country.Code","time"),timevar="Series.Name")
  row.names(CSC2) <- NULL
  
  detach("package:reshape",unload=T)
  return(CSC2)
  
}




