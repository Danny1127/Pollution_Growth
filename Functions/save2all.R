### save data to different sources
save2all <- function(mydata,filename,filetype){
  if (filetype=="R"){
    save(mydata,file= paste0("OutputData/",filename,".RData"))
  }else if (filetype=="CSV"){
    write.csv(mydata,file=paste0("OutputData/",filename,".csv"),row.names = F)
    
  }else if (filetype=="Stata"){
    library(foreign)
    write.dta(mydata, paste0("OutputData/",filename,".dta") )
    
  }else if (filetype=="all"){
    save(mydata,file= paste0("OutputData/",filename,".RData"))
    write.csv(mydata,file=paste0("OutputData/",filename,".csv"),row.names = F)
    library(foreign)
    write.dta(mydata, paste0("OutputData/",filename,".dta") )
    
  }

  
}