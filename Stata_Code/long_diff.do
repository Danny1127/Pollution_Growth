// load data and call other plot scripts
clear all
set more off
set scheme s1color
cd "C:/Users/Karuma/Documents/Pollution_Growth"
use "OutputData/long_diff", clear
global code_folder "Code/Stata_Code"

do "$code_folder/Functions/get_date.do" // get $folder_time

global graph_folder0 "Graph/long_diff$folder_date"
capture mkdir "$graph_folder0"

* repeat msize for the number of groups
foreach x of var CSC*{
	
	global graph_folder "$graph_folder0/`x'"
	capture mkdir "$graph_folder"
	
	global group_var "`x'"
	* group if too many distinct values
	egen groups = group(`x')
	sum groups
	if r(max)>5{
		sum $group_var
		local mybin = (r(max)-r(min) )/5
		replace $group_var = round($group_var ,`mybin')
	}
	drop groups
	
	levelsof $group_var, local(glevels)
	
	local size "tiny"
	*local symbol "O"
	local label0 "Country_Code"
	local labelsize "tiny"

	local msize "`size' "
	*local msymbol "`symbol' "
	local legend "order( 1 `min' "
	local mlabel "`label0' "
	local mlabelsize "`labelsize' "

	foreach t of local glevels{
		disp "`t'"
		local msize "`msize' `size'"
		*local msymbol "`msymbol' `symbol'"
		
		local mlabelsize "`mlabelsize' `labelsize'"
		local mlabel "`mlabel' `label0'"
	}
	global legend "size(vsmall)" //"`legend' ) cols(2)"
	global msymbol "O D T X S +" //"`msymbol'"
	global msize "`msize'"
	global mlabel "`mlabel'"
	global mlabelsize "`mlabelsize'"

	
	//do "$code_folder/Plots/LD_Year.do"
	do "$code_folder/Plots/LD_byYear.do"
}

/*
	do "$code_folder/Plots/NetCY_FE.do"
	do "$code_folder/Plots/dln_GDPvsPM25.do"
*/
