%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR"
cd %eviews_path
%EviewsRGroup="EviewsRGroup1a104f6b7ce5"
%wf="EViewsR1a10415f2174"
%page="EViewsR1a10415f2174"
%series="a b"
%graph_command="line"
%options="m"
%mode="overwrite"
%file_name=""
%save_path=""
%save_options="t=png,dpi=300"
close @wf

%align=@wreplace(%align,"* ","*")
%align="align("+%align+")"

if %wf<>"" then
wfopen {%wf}
endif

if %page<>"" then
pageselect {%page}
endif

if %mode<>"" then
%mode="mode="+%mode+","
string mode="mode="+%mode+","
endif

%z=@wlookup(%series,"series")
%graph_command=@wreplace(%graph_command,"* ","*")
%mode=@wreplace(%mode,"* ","*")
%file_name=@wreplace(%file_name,"* ","*")
%save_path=@wreplace(%save_path,"* ","*")
%save_path=@wreplace(%save_path,"/","\")
%save_options=@wreplace(%save_options,"* ","*")

if %save_options<>"" then
%save_options="("+%save_options+")"
endif

if %options<>"" then
%options="("+%options+")"
endif


group {%EviewsRGroup} {%z}
!n={%EviewsRGroup}.@count

for !k=1 to {!n}
%x{!k}={%EviewsRGroup}.@seriesname({!k})


freeze({%mode}{%x{!k}}_graph_EviewsR) {%x{!k}}.{%graph_command}{%options}

'	if %save="TRUE" or %save="T" then
'
if %save_path<>"" then
%save_path=%save_path+"\"
endif
{%x{!k}}_graph_EviewsR.save{%save_options} {%save_path}{%x{!k}}_graph_EviewsR
'	endif
'
next


if %merge_graph<>"TRUE" or %merge_graph<>"T" then
%seriesNames=@replace(%z," ","")
freeze({%mode}{%seriesNames}_graph_EviewsR) {%EviewsRGroup}.{%graph_command}{%options}
'{%seriesNames}_graph_EviewsR.{%align}
'		if %save="TRUE" or %save="T" then
{%seriesNames}_graph_EviewsR.save{%save_options} {%save_path}{%seriesNames}_graph_EviewsR
endif

%allEviewsGraphs=@wlookup("*","graph")


for %y {%allEviewsGraphs}

%freq=@pagefreq
  if %freq="m" or %freq="M" then
  {%y}.datelabel format("YYYY")
  endif
  if %freq="D7" or %freq="D5"  or %freq="d5"  or %freq="d7" then
  {%y}.datelabel format("Mon YYYY")
  endif
{%y}.textdefault font("Times",20,-b,-i,-u,-s)
{%y}.align(2,1,1)
{%y}.datelabel format("YY")
next


