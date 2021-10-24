%action="equation"
%action_opt="mode=overwrite" 
%object_name="eq2" 
%view_or_proc="ls" 
{%options_list}="" 
%arg_list="y ar(1)" 

if 
{%object_type}({%options}) {%object_name}

{%action}({%action_opt}) {%object_name}.{%view_or_proc}({%options_list}) {%arg_list}


