### call all scripts
rm(list=ls())
source("Code/Functions/save2all.R")
### single year
### read data from csv: "Data/PM25/GlobalGWRc/*" + "Data/GDP/GDP.csv" & "Data/Position.csv"
# source("code/ReadData.R")  ### =>"Data/GDP_PM25_CSC" RData, csv and dta

  ### called by ReadData.R
  # source("code/Functions/readPM25.R")
     
  ### used in ReadData.R, add CSC to PM25 and GDP
  # source("code/link_CSC.R")
  
  ### called by link_data_less.R
  # source("code/Functions/readGDP.R")
  # source("code/Functions/readCPos.R")

  ### called by link_CSC.R read country statistics capacity
  # source("code/readCSC.R")


 


### analysis for test, not ready
# source("code/analysis.R") ### input : "Data/GDP_PM25.RData"

### construct long diff
source("code/Plots.R")





