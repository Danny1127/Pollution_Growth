### save data to different sources
save2all <- function(mydata,filename,filetype){
  if (filetype=="R"){
    save(mydata,file= paste0(filename,".RData"))
  }else if (filetype=="CSV"){
    write.csv(mydata,file=paste0(filename,".csv"),row.names = F)
    
  }else if (filetype=="Stata"){
    library(foreign)
    write.dta(mydata, paste0(filename,".dta") )
    detach("package:foreign",unload=T)
  }

  
}