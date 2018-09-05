// get current date
local today : disp %td date("$S_DATE","DMY")
local ctime : disp "$S_TIME"
local ctime=subinstr("`ctime'",":","_",.)
global folder_time: disp "`today'_`ctime'"
global folder_date : disp "`today'"

disp "$folder_time"
