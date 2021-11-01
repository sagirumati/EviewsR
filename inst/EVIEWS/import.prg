%wf=""
%page=""
%options=""
%source_description=""
%table_description="" 
%keep_list="" 
%drop_list=""
%keepmap_list=""
%dropmap_list=""
%smpl_spec=""

%runpath=@runpath
cd %runpath
open {%wf}

wfcreate m 2000 2020
%variables="wf page rndseed series"
%variables=@wreplace(%variables,"* ","*") 'remove unwanted space
string function_arguments=@replace(%variables," ","="""",")
%variables1=@replace(%variables," ","+@chr(13)+") 'replace space with @CHR(13) to create a NEWLINE (RETURN).
string writeLines=@replace(%variables," ",",") 'create a list for WRITELINES in R
for %y {%variables}
string {%y}=%y+"=paste0('%"+%y+"=',shQuote("+%y+"))"
next
string variablesss={%variables1}
delete {%variables}

if %page<>"" then
pageselect {%page}
endif

'if %path<>"" then
'%source_description=%path+"\"+%source_description 'PATH not needed
'endif

if %keep_list<>"" then
%keep_list="@keep "+%keep_list
endif


if %drop_list<>"" then
%drop_list="@drop "+%drop_list
endif

if %keepmap_list<>"" then
%keepmap_list="@keepmap "+%keepmap_list
endif

if %dropmap_list<>"" then
%dropmap_list="@dropmap "+%dropmap_list
endif


if %smpl_spec<>"" then
%smpl_spec="@smpl "+%smpl_spec
endif

pagesave {%source_description} {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}


