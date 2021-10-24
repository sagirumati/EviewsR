
'import example.csv @freq m 1990 @genr yy=ser^2 @rename ser aa

'%type=""
'%options=""
%path=@runpath
cd %path 
if %type<>"" then
%type="type="+%type   'to avoid error if %TYPE=""
endif

if %type<>"" then
%type="type="+%type   'to avoid error if %TYPE=""
endif
%source_description="example.csv" 
'%import_specification
%smpl_string="" 
if %smpl_string<>"" then
%smpl_string="@smpl "+%smpl_string 'change %SMPL_STRING to @SMPL %SMPL_STRING if %SMPL_STRING<>""
endif  

%genr_string="yy=ser^2"
if %genr_string<>"" then
%genr_string="@genr "+%genr_string
endif  

%rename_string="ser aa"
if %rename_string<>"" then
%rename_string="@rename "+%rename_string
endif  

'DATED 
%frequency="m"
%start_date="1990" 


%id=""
%destid=""

'APPENDED
%append="T" 

'Determine the IMPORT_SPECIFICATION for DATED

if %frequency<>"" or %start_date<>"" then
%import_type="dated" 
%import_specification="@freq "+%frequency+" "+%start_date
endif

if %id<>"" or %destid<>"" then
%import_type="match-merged" 
%import_specification="@id "+%id+" @destid"+" "+%destid
endif

if (%append="T" or %append="TRUE") and %id="" and %destid="" and %frequency="" and %start_date="" then
%import_type="appended" 
%import_specification="@append" 
endif

if %id="" and %destid="" and %import_specification=""  then
%import_type="sequential" 
%import_specification=""
endif



'OPTIONAL_ARGUMENTS=@smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}


%optional_arguments=%smpl_string+" "+%genr_string+" "+%rename_string
if %import_type="appended" then
%optional_arguments=%genr_string+" "+%rename_string 'APPENDED syntax does not contain @SMPL_STRING
endif
'GENERAL
import({%type}, {%options}) {%source_description} {%import_specification} {%optional_arguments}


'
''DATED 
'import(type={%type}, {%options}) {%source_description} @freq {%frequency} {%start_date} @smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}
'
''MATCH-MERGED
'
'import(type={%type}, {%options}) {%source_description} @id {%id} @destid {%destid}  @smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}
'
''APPENDED  
'
'import(type={%type}, {%options}) {%source_description} @append @smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}
'
'
''SEQUENTIAL
'
'import(type={%type}, {%options}) {%source_description} @smpl {%smpl_string} @genr {%genr_string} @rename {%rename_string}
'

'GENERAL
'import([type=], options) source_description import_specification [@smpl smpl_string] [@genr genr_string] [@rename rename_string]

'DATED
'import([type=], options) source_description @freq frequency start_date [@smpl smpl_string] [@genr genr_string] [@rename rename_string]

'MATCH-MERGED
'import(options) source_description @id id @destid destid [@smpl smpl_string] [@genr genr_string] [@rename rename_string]

'SEQUENTIAL
'import(options) source_description [@smpl smpl_string] [@genr genr_string] [@rename rename_string]

'APPEND
'import(options) source_description @append [@genr genr_string] [@rename rename_string]




'if %smpl_string<>"" and %genr_string="" and %rename_string="" then
'%optional_arguments="@smpl "+%smpl_string
'endif
'
'if %smpl_string<>"" and %genr_string<>"" and %rename_string="" then
'%optional_arguments="@smpl "+%smpl_string+" @genr "+%genr_string
'endif
'
'if %smpl_string<>"" and %genr_string="" and %rename_string<>"" then
'%optional_arguments="@smpl "+%smpl_string+" @rename "+%rename_string
'endif
'
'
'if  %smpl_string="" and %genr_string<>"" and %rename_string="" then
'%optional_arguments=" @genr "+%genr_string
'endif
'
'if  %smpl_string="" and %genr_string<>"" and %rename_string<>"" then
'%optional_arguments="@genr "+%genr_string+" @rename "+%rename_string
'endif
'
'if %smpl_string="" and %genr_string="" and %rename_string<>"" then
'%optional_arguments="@rename "+%rename_string
'endif
'
'if %smpl_string<>"" and %genr_string<>"" and %rename_string<>"" then
'%optional_arguments="@smpl "+%smpl_string+" @genr "+%genr_string+" @rename "+%rename_string
'endif
'


