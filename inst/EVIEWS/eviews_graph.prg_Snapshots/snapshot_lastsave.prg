'%wf="workfile"
'%page="page"
'%series="x y"
'%graph_command="   line   "
'%options=" m  "
'%dev=" pdf "
'%mode="overwrite   "
'%file_name="some name"
'%save="T"
'%save_path="path "     'PATH should be relative to the CWD

%path=@runpath
cd %path
close @wf
wfopen {%wf}
pageselect {%page}
%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* *","**")
%mode=@wreplace(%mode,"* *","**")
!mode=@isempty(%mode)
%file_name=@wreplace(%file_name,"* *","**")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")
!save_path=@isempty(%save_path)
group EviewsR_group {%z}
!n=EviewsR_group.@count

for !k=1 to {!n}
	%x{!k}=EviewsR_group.@seriesname({!k})
	
	if %mode="overwrite" then
		freeze(mode={%mode},{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}
	endif
	
	if !mode=1 then
		freeze({%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}
	endif 
	
	if %save="TRUE" or %save="T" then
		if !save_path=1 then
			{%x{!k}}_graph_EviewsR.save(t={%dev}) {%x{!k}}_graph_EviewsR
		endif
		if !save_path=0 then
			'%save_path=%save_path+"\"+%file_name
			{%x{!k}}_graph_EviewsR.save(t={%dev}) {%save_path}\{%x{!k}}_graph_EviewsR
		endif 
	endif
next

for %y {%z}
	
	if %mode="overwrite" then
		freeze(mode={%mode},graph_EviewsR) EviewsR_group.{%graph_command}({%options}) 
	endif
	
	if !mode=1 then
		freeze(graph_EviewsR) EviewsR_group.{%graph_command}({%options})
	endif
	
	
	graph_EviewsR.align(2,1,1)
	if %save="TRUE" or %save="T" then
		if !save_path=1 then
			graph_EviewsR.save(t={%dev}) %file_name
		endif
		if !save_path=0 then
			graph_EviewsR.save(t={%dev}) {%save_path}\{%file_name} 
		endif
	endif
next

%allGraphs=@wlookup("*","graph")
for %y {%allGraphs}
	{%y}.textdefault font(Times New Roman,20,-b,-i,-u,-s)
	%freq=@pagefreq
	if %freq="m" or %freq="M" then
		{%y}.datelabel format("YYYY")
	endif
	if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
		{%y}.datelabel format("Mon YYYY")
	endif
next

'%mergeName="graphs_of_"+@replace(%z," ","_")
'%z=@wlookup("graph_*","graph")
'graph {%mergeName}.merge {%z}
'{%mergeName}.align(2,1,1)







close @wf

%align=@wreplace(%align,"* ","*")
%align="align("+%align+")"

if %wf<>"" then
	wfopen {%wf}
endif

if page<>"" then
	pageselect {%page}
endif

%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* ","*")
%mode=@wreplace(%mode,"* ","*")
%file_name=@wreplace(%file_name,"* ","*")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")
%save_optioins=@wreplace(%save_optioins,"* ","*")

if %save_optioins<>"" then
%save_optioins="("+%save_optioins+")"
endif

if %options<>"" then
%options="("+%options+")"
endif


group {%EviewsRGroup} {%z}
!n={%EviewsRGroup}.@count

for !k=1 to {!n}
	%x{!k}={%EviewsRGroup}.@seriesname({!k})
	
	if mode<>"" then
		%mode="mode="+%mode+","
	endif
	
	freeze({%mode}{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}{%options}
'	
'	if %save="TRUE" or %save="T" then
'		
	if %save_path<>"" then
		%save_path=%save_path+"\"
	endif
		{%x{!k}}_graph_EviewsR.save{%save_optioins} {%save_path}{%x{!k}}_graph_EviewsR
'	endif
'
next
	


%seriesNames=@replace(%z," ","")
			freeze({%mode}{%seriesNames}_graph_EviewsR) {%EviewsRGroup}.{%graph_command}{%options}		
{%seriesNames}_graph_EviewsR.{%align}
'		if %save="TRUE" or %save="T" then
		{%seriesNames}_graph_EviewsR.save{%save_optioins} {%save_path}{%file_name}
				


	%allEviewsGraphs=@wlookup("*","graph")
	for %y {%allEviewsGraphs}
		{%y}.textdefault font(Times New Roman,20,-b,-i,-u,-s)
		%freq=@pagefreq
		if %freq="m" or %freq="M" then
			{%y}.datelabel format("YYYY")
		endif
		if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
			{%y}.datelabel format("Mon YYYY")
		endif
	next


