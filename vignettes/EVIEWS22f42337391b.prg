%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR\vignettes"
cd %eviews_path
%wf="eviewr_export"
%wf1="eviewr_export"
%save_path=""

%options=""
%source_description=""
%smpl_string=""
%genr_string=""
%rename_string=""
%frequency="m"
%start_date="1990"
%id=""
%destid=""
%append="FALSE"

  %wf2=%wf+".wf1"
 if %wf1<>"" and @fileexist(%wf2) and %start_date="" then
open {%wf1}
  endif

  if %type<>"" then
  %type="type="+%type+","   'to avoid error if %TYPE=""
  endif


  if %option<>"" then
  %option="option="+%option   'to avoid error if %option=""
  endif

  if %smpl_string<>"" then
  %smpl_string="@smpl "+%smpl_string 'change %SMPL_STRING to @SMPL %SMPL_STRING if %SMPL_STRING<>""
  endif

  if %genr_string<>"" then
  %genr_string="@genr "+%genr_string
  endif

  if %rename_string<>"" then
  %rename_string="@rename "+%rename_string
  endif

  'Determine the IMPORT_SPECIFICATION for DATED

  if %frequency<>"" and %start_date<>"" then
  %import_type="dated"
  %import_specification="@freq "+%frequency+" "+%start_date
  endif

  if %id<>"" and %destid<>"" then
  %import_type="match-merged"
  'open {%wf}
  %import_specification="@id "+%id+" @destid"+" "+%destid
  endif

  if (%append="T" or %append="TRUE") and %id="" and %destid="" and %frequency="" and %start_date="" then
  %import_type="appended"
  'open {%wf}
    %import_specification="@append"
  endif

  if %id="" and %destid="" and %import_specification=""  then
  %import_type="sequential"
  'open {%wf}
  %import_specification=""
  endif



  'OPTIONAL_ARGUMENTS=@smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}


  %optional_arguments=%smpl_string+" "+%genr_string+" "+%rename_string
  if %import_type="appended" then
 'open {%wf}
  %optional_arguments=%genr_string+" "+%rename_string 'APPENDED syntax does not contain @SMPL_STRING
  endif
  'GENERAL
  import({%type}{%options}) {%source_description} {%import_specification} {%optional_arguments}

  %wf=@wfname

  if %save_path<>"" then
  %save_path=%save_path+"/"
  endif

  wfsave {%save_path}{%wf}

exit
  
