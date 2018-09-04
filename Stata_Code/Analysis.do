// analyze
clear all
set more off
cd "C:/Users/Karuma/Documents/Pollution_Growth"
use "Data/GDP_PM25", clear

gen GDP2 = GDP^2

reg Population_Weightd_PM2_5__g_m3_ GDP 

reg Population_Weightd_PM2_5__g_m3_ GDP*

// before controlling anything
gen ln_GDP = log(GDP)
foreach x in 10 15 25 35{
	scatter Population__`x'* ln_GDP, msize(tiny) name(s`x')
}
graph close _all
graph combine s10 s15 s25 s35

graph export "Graph/PM_ln_GDP.png", replace

// for population weighted pm2.5
scatter Population_Weightd_PM2_5__g_m3_ ln_GDP, msize(tiny) 
graph export "Graph/PopW_PM25_ln_GDP.png", replace


scatter Population_Weightd_PM2_5__g_m3_ ln_GDP, by(Year) msize(tiny) 
graph export "Graph/PopW_PM25_ln_GDP.png", replace

// change rate for each country 
