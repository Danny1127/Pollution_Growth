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

forval year=2010/2017{
	#delimit ;
	twoway (scatter `y'_* `x' if Year==`year', msize($msize )  msymbol($msymbol ) mlabel($mlabel ) mlabsize($mlabelsize )) 
		   (lfit `y' `x'  if Year==`year' ),
			legend( $legend ) xtitle("`x'") ytitle("`y'")
			note("Year `year'");
			
	#delimit cr
	graph export "$graph_folder/`year'.png", replace
}
drop `y'_*
drop `new_name'

