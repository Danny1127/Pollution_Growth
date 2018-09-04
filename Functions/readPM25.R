### read PM2.5

readPM25 <- function(data_folder){
  PM25 <- data.frame()
  myfiles <- list.files(path=data_folder)
  ### select csv
  myfiles <- myfiles[grep("csv",myfiles)]
  
  for (file in myfiles){
    ### read data
    #print(file)
    if (file == "Unified_PM25_GL_200101_201012-RH35-minc0_Median-countries.csv"){
      #skip reading file
      
    }else{
      xdata <- read.csv(file=paste0(data_folder,file))
      ### get period info from file name
      xdata$Period <- substr(file,gregexpr("_",file)[[1]][3]+1,gregexpr("-",file)[[1]][1]-1)
      PM25 <- rbind(PM25 , xdata)
    }
  }
  
  print(names(PM25))
  ### rename for unified
  if (ncol(PM25)==7 & grepl("Unified",file)){
    names(PM25)<-c("Country","PopWeight_ugm3","GeoMean_ugm3","PopCov","GeoCov","TotPop_mil","Period")
  }
 
  return(PM25)
}
