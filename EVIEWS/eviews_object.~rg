'wf="" 
'%action="equation"
'%action_opt="mode=overwrite" 
'%object_name="eq2" 
'%view_or_proc="ls" 
'{%options_list}="" 
'%arg_list="y ar(1)" 

'{%object_type}({%options}) {%object_name} 'SYNTAX FOR DECLARATION
wfopen {%wf}
if %action_opt<>"" then
%action_opt="("+%action_opt+")" 
endif
'

if %view_or_proc<>"" then
%view_or_proc="."+%view_or_proc 
endif

if %options_list<>"" then
%options_list="("+%options_list+")" 
endif

{%action}{%action_opt} {%object_name}{%view_or_proc}{%options_list} {%arg_list}


