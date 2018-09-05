rm(list=ls())
### summary of missing values
load("RData/GDP_PM25.RData")


cat("Missing Population Weighted PM25 by Year")
print(with(GDP_PM25_CSC,table(is.na(Population.Weighted.PM2.5..ug.m3.),Year)))


cat("Missing GDP by Year")
print(with(GDP_PM25_CSC,table(is.na(GDP),Year)))

cat("Missing CSC Poverty Survey by Year")
print(with(GDP_PM25_CSC,table(is.na(`CSC.Poverty survey`),Year)))

cat("Missing CSC Per capita GDP growth by Year")
print(with(GDP_PM25_CSC,table(is.na(`CSC.Per capita GDP growth`),Year)))

cat("Missing CSC Income poverty by Year")
print(with(GDP_PM25_CSC,table(is.na(`CSC.Income poverty`),Year)))


### for long difference
rm(list=ls())
load("OutputData/long_diff.RData")
### rename data set
long_diff<-mydata
rm("mydata")

cat("Missing CSC Income poverty by Year")
print(with(long_diff,table(is.na(`CSC.Income_poverty`),Year)))

cat("Missing ln_PM25_diff by Year")
print(with(long_diff,table(is.na( ln_PM25_diff),Year)))

cat("Missing ln_GDP_diff by Year")
print(with(long_diff,table(is.na( ln_GDP_diff),Year)))
