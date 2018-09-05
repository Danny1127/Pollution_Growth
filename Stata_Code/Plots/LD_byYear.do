// plot dln_GDP vs dln_PM25, for each year, color by CSC

local x "ln_PM25_diff"
local y "ln_GDP_diff"

local group "$group_var"
decode `group', gen(`group'_ )
local new_name = substr("`group'",1,10)
rename `group' `new_name'
rename `group'_ `group'
replace `group' = "NA"  if `group'==""
separate `y', by(`group') gen("`y'_")

#delimit ;
twoway (scatter `y'_* `x' ,by(Year) subtitle(,lcolor(gs13) size(tiny)) msize($msize )  msymbol($msymbol )) 
	   (lfit `y' `x'  ,by(Year)  ), 
	   ylabel(, labsize(tiny)) xlabel(,labsize(tiny))
		legend( $legend ) xtitle("`x'") ytitle("`y'");		
#delimit cr
graph export "$graph_folder/byYear.png", replace

drop `y'_*
drop `new_name'

