### plot for PM25 vs GDP
rm(list=ls())
load("RData/GDP_PM25.RData")

library(dplyr)
library(psych)
library(ggplot2)

#library(ggrepel)

names(GDP_PM25_CSC) <- gsub(" |/|[(]|[)]","_",names(GDP_PM25_CSC))
for (target in names(GDP_PM25_CSC)[grep("CSC",names(GDP_PM25_CSC))]){
  GraphFolder <- paste0("Graph/",gsub("CSC.","",target),"/")
  dir.create(GraphFolder,showWarnings = F)
 
  ### plot long difference color by each CSC
  for (FinalYear in 2010:2017){
    InitialYear <- FinalYear - 10
    ### long diff
    long_diff0 <- GDP_PM25_CSC %>% filter(Year==FinalYear|Year==InitialYear) %>%
      group_by(Country) %>% arrange(Year) %>% mutate(ln_GDP = log(GDP), ln_GDP_diff = ln_GDP-lag(ln_GDP),
                                                     ln_PM25 = log(Population.Weighted.PM2.5..ug.m3.),
                                                     ln_PM25_diff = ln_PM25 - lag(ln_PM25)) %>%
      filter(Year==FinalYear)

    ### plot for long difference of raw
    p <- ggplot(data=long_diff0,aes_string(x="ln_PM25_diff",y="ln_GDP_diff",color=target)) + geom_point() + theme_bw()+ 
      geom_text(aes(label=Country.Code),hjust=0, vjust=0,alpha=0.25)+
      labs(title="Long Difference of log",x=paste0("ln(PM25 in ",FinalYear,") - ln(PM25 in ",InitialYear,")"),
           y=paste0("ln(GDP in ",FinalYear,") - ln(GDP in ",InitialYear,")")) #+geom_smooth(method='lm',formula=y~x)
    
    p
    filename <- paste0(GraphFolder,"LD_",InitialYear,"_",FinalYear,".png")
    ggsave(file=filename,p,device="png")
   
  }
  # 
  # diff <- GDP_PM25_CSC %>% group_by(Country) %>% arrange(Year) %>% mutate(ln_GDP = log(GDP), ln_GDP_diff = ln_GDP-lag(ln_GDP),
  #                                                                         ln_PM25 = log(Population.Weighted.PM2.5..ug.m3.),
  #                                                                         ln_PM25_diff = ln_PM25 - lag(ln_PM25))
  # g<- ggplot(data=diff,aes_string(x="ln_PM25_diff",y="ln_GDP_diff",color=target,frame="Year")) +  geom_point() + theme_bw()+ 
  #   geom_text(aes(label=Country.Code),hjust=0, vjust=0,alpha=0.25)+
  #   labs(title="Long Difference of log",x=paste0("ln(PM25 in ",FinalYear,") - ln(PM25 in ",InitialYear,")"),
  #        y=paste0("ln(GDP in ",FinalYear,") - ln(GDP in ",InitialYear,")"))
  # 
  
}



# +geom_text_repel(aes(label=Country.Code),
# nudge_y       = 0.7 - subset(long_diff1, GDP_diff>0.3)$GDP_diff,
# segment.size  = 0.2,
# segment.color = "grey50",
# direction     = "x")





detach("package:dplyr",unload=T)  
detach("package:psych",unload=T)  
detach("package:ggplot2",unload=T)  
