%path=@runpath
cd %path
%wf="eviews/workfile"
%page="page"
%series="x y"
%graph_command="line"
%options=""
%mode="overwrite"
%file_name=""
%save_path=""
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
