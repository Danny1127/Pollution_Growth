rm(list=ls())
### analysis
load("Data/GDP_PM25.RData")
GDP_PM25$ln_GDP <- log(GDP_PM25$GDP)
GDP_PM25$ln_GDP2 <- GDP_PM25$GDP^2


GDP_PM25$highGDP <- ifelse(GDP_PM25$GDP>1e5,1,0)
GDP_PM25$GDP_seg <- with(GDP_PM25,factor(ifelse(GDP<=0.5e4,0,ifelse(GDP<=1e4,1,ifelse(GDP<2e4,2,ifelse(GDP<1e5,3,4))))))

lfit<-lm(ln_GDP~PopWeight_ugm3*highGDP,data=GDP_PM25)
print(summary(lfit))
lfit<-lm(ln_GDP~PopWeight_ugm3*GDP_seg,data=GDP_PM25)
print(summary(lfit))


lfit<-lm(GDP~PopWeight_ugm3*highGDP,data=GDP_PM25)
print(summary(lfit))
lfit<-lm(GDP~PopWeight_ugm3*GDP_seg,data=GDP_PM25)
print(summary(lfit))

### regression for quadratic, Kuznets curve
lfit<-lm(PopWeight_ugm3~GDP+GDP^2, data=GDP_PM25)
print(summary(lfit))

lfit<-lm(PopWeight_ugm3~GDP, data=GDP_PM25)
print(summary(lfit))


