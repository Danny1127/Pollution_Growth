// analyze

*====================================================
* net of country and year fixed effect
*====================================================
qui xi: reg ln_GDP i.Country i.Year
predict res_ln_GDP, resid
label var res_ln_GDP "residual ln_GDP"
qui xi: reg ln_PM25 i.Country i.Year
predict res_ln_PM25, resid
label var res_ln_PM25 "residual ln_PM25"

local y "res_ln_GDP"
local x "res_ln_PM25"

separate `y' , by(Year) shortlabel gen("`y'_")

#delimit ;
twoway (scatter `y'_* `x', msize($msize )  msymbol($msymbol )) 
	(lfit `y' `x'), 
	legend($legend ) title("Net of Country & Year FE")
	 xtitle("`x'") ytitle("`y'") 
;
#delimit cr
graph export "$graph_folder/NetCY_FE.png", replace
qui drop res_ln_GDP res_ln_PM25
