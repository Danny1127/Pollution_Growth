// plot dln_GDP vs dln_PM25

separate ln_GDP_diff , by(Year) gen(dln_GDP_)
gen dln_GDP = ln_GDP_diff

local x "ln_PM25_diff"
local y "dln_GDP"

#delimit ;
twoway (scatter `y'_* `x' , msize($msize )  msymbol($msymbol )) 
	   (lfit `y' `x'    ),
	    legend( $legend ) xtitle("`x'") ytitle("`y'");
#delimit cr
graph export "$graph_folder/dln_GDPvsPM25.png", replace
